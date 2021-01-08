rabbitmq 工作原理：
		  routing_key		binding_key
	P(生产者)------------->Exchange------------->queue----->C（消费者）
生产者产生消息并指定routing_key 到交换机 跟据routing_key与binding_key匹配方式发送到指定的queue队列。

Exchage tpyes：的匹配类型：
	fanout:把所有发送到交换机的消息路由至与它绑定的queue队列。
	direct:把binding_key与routing_key完全匹配，分发到binding_key指定的queue队列中。
	topic:与 direct一样，只是支持了模糊匹配*全部#号为一个单词。比如有一个消息是stock.usb.ney ，*.usb.*就会匹配。
	headers:按头部匹配。
	rpc:用于同步的匹配。
