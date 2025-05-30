package alert

import (
	"context"
	"fmt"

	"AutoDataHub-monitor/configs"
	"AutoDataHub-monitor/pkg/utils"
)

var logger = configs.Client.Logger

// checkRedisQueueLength 监控 Redis 队列长度并在超过阈值时发送飞书告警
// ctx: 上下文
// queueName: Redis 队列名称
// threshold: 队列长度阈值
func checkRedisQueueLength(ctx context.Context, queueName string, threshold int) {
	length, err := configs.Client.Redis.LLen(ctx, queueName).Result()
	if err != nil {
		logger.Sugar().Errorf("检查队列长度失败: %v", err)
		return
	}

	if length >= int64(threshold) {
		msg := fmt.Sprintf("Alert: Queue %s length %d exceeds or equals threshold %d", queueName, length, threshold)
		if err := utils.SendFeishuMessage(msg); err != nil {
			logger.Sugar().Errorf("发送飞书消息失败: %v", err)
		}
	}
}

// CheckAllRedisQueueLength 检查所有配置的 Redis 队列长度
// 返回可能遇到的错误信息
func CheckAllRedisQueueLength(ctx context.Context) error {
	defer func() {
		if err := recover(); err != nil {
			logger.Sugar().Errorf("捕获到 panic：%v\n", err)
		}
	}()

	var errs []error
	configs.Cfg.VehicleType.ForEach(func(fieldName, value string) {
		if _, err := configs.Client.Redis.Ping(ctx).Result(); err != nil {
			errs = append(errs, fmt.Errorf("Redis连接失败: %w", err))
			return
		}
		checkRedisQueueLength(ctx, value, 1000)
	})

	if len(errs) > 0 {
		return fmt.Errorf("遇到%d个错误: %+v", len(errs), errs)
	}
	return nil
}
