DROP DATABASE IF EXISTS `pmhub-nacos`;

CREATE DATABASE  `pmhub-nacos` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

USE `pmhub-nacos`;

/******************************************/
/*   表名称 = config_info   */
/******************************************/
CREATE TABLE `config_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) DEFAULT NULL,
  `content` longtext NOT NULL COMMENT 'content',
  `md5` varchar(32) DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text COMMENT 'source user',
  `src_ip` varchar(50) DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) DEFAULT NULL,
  `tenant_id` varchar(128) DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) DEFAULT NULL,
  `c_use` varchar(64) DEFAULT NULL,
  `effect` varchar(64) DEFAULT NULL,
  `type` varchar(64) DEFAULT NULL,
  `c_schema` text,
  `encrypted_data_key` text COMMENT '秘钥',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfo_datagrouptenant` (`data_id`,`group_id`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info';

INSERT INTO `pmhub-nacos`.`config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`, `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`, `encrypted_data_key`) VALUES (1, 'application-dev.yml', 'DEFAULT_GROUP', 'spring:\n  autoconfigure:\n    exclude: com.alibaba.druid.spring.boot.autoconfigure.DruidDataSourceAutoConfigure\n  mvc:\n    pathmatch:\n      matching-strategy: ant_path_matcher\n# 项目相关配置\npmhub:\n  # 名称\n  name: laigeoffer-pmhub\n  # 版本\n  version: 1.0.0\n  # 版权年份\n  copyrightYear: 2024\n  # 实例演示开关\n  demoEnabled: true\n  # 获取ip地址开关\n  addressEnabled: false\n  # 验证码类型 math 数组计算 char 字符验证\n  captchaType: math\n  # 本地开发请修改 profile 为对应系统的路径 切记不能提交 保证 profile: /data/uploadPath 始终是这个 因为容器部署挂载的这个路径\n  # Mac /usr/local/pmhub/uploadPath\n  # Win D:/pmhub/uploadPath\n  profile: /data/uploadPath\n\n# 日志配置\nlogging:\n  level:\n    com.laigeoffer.pmhub: info\n    org.springframework: warn\n  # 日志路径配置：测试及线上环境请勿修改保证 path: /data/logs 始终是这个 因为容器部署挂载的这个路径，本地环境可修改自己的存储路径\n  file:\n    name: logs/${spring.application.name}/info.log\n    path: /data/logs\n\n# 用户配置\nuser:\n  password:\n    # 密码最大错误次数\n    maxRetryCount: 5\n    # 密码锁定时间（默认10分钟）\n    lockTime: 10\n\n# token配置\ntoken:\n  # 令牌自定义标识\n  header: Authorization\n  # 令牌密钥\n  secret: abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz\n  # 令牌有效期\n  expireTime: 600\n  \n\n# MyBatis-plus 配置\nmybatis-plus:\n  # 搜索指定包别名\n  typeAliasesPackage: com.laigeoffer.pmhub.**.domain\n  # 配置mapper的扫描，找到所有的mapper.xml映射文件\n  mapperLocations: classpath*:mapper/**/*Mapper.xml\n  # 加载全局的配置文件\n  configLocation: classpath:mybatis/mybatis-config.xml\n          \n# PageHelper分页插件\npagehelper:\n  helperDialect: mysql\n  supportMethodsArguments: true\n  params: count=countSql\n\n# Swagger配置\nswagger:\n  # 是否开启swagger\n  enabled: true\n  # 请求前缀\n  pathMapping: /dev-api\n\n# 防止XSS攻击\nxss:\n  # 过滤开关\n  enabled: true\n  # 排除链接（多个用逗号分隔）\n  excludes: /system/notice\n  # 匹配链接\n  urlPatterns: /system/*,/monitor/*,/tool/*\n\n  \n\n# feign 配置\nfeign:\n  sentinel:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n      min-request-size: 8192\n    response:\n      enabled: true\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\n\n\n# 实时log配置，可在http://localhost:6888/ 监控中心查看实时日志\n\n', 'f159ff8f167c87aa4070eb7debc7d789', '2020-05-20 12:00:00', '2024-05-16 09:45:42', NULL, '0:0:0:0:0:0:0:1', '', '', '通用配置', 'null', 'null', 'yaml', '', '');
INSERT INTO `pmhub-nacos`.`config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`, `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`, `encrypted_data_key`) VALUES (2, 'pmhub-gateway-dev.yml', 'DEFAULT_GROUP', 'spring:\n  redis:\n    host: localhost\n    port: 6379\n    password:\n  cloud:\n    gateway:\n      discovery:\n        locator:\n          lowerCaseServiceId: true\n          enabled: true\n      routes:\n        # 认证中心\n        - id: pmhub-auth\n          uri: lb://pmhub-auth\n          predicates:\n            - Path=/auth/**\n          filters:\n            # 验证码处理\n            - CacheRequestFilter\n           # - ValidateCodeFilter\n            - StripPrefix=1\n        # 代码生成\n        - id: pmhub-gen\n          uri: lb://pmhub-gen\n          predicates:\n            - Path=/gen/**\n          filters:\n            - StripPrefix=0\n        # 定时任务\n        - id: pmhub-job\n          uri: lb://pmhub-job\n          predicates:\n            - Path=/schedule/**\n          filters:\n            - StripPrefix=0\n        # 系统模块\n        - id: pmhub-system\n          uri: lb://pmhub-system\n          predicates:\n            - Path=/system/**\n          filters:\n            - StripPrefix=0\n        # 项目模块\n        - id: pmhub-project\n          uri: lb://pmhub-project\n          predicates:\n            - Path=/project/**\n          filters:\n            - StripPrefix=0\n        # 流程模块\n        - id: pmhub-workflow\n          uri: lb://pmhub-workflow\n          predicates:\n            - Path=/workflow/**\n          filters:\n            - StripPrefix=0\n\n# 安全配置\nsecurity:\n  # 验证码\n  captcha:\n    enabled: false\n    type: math\n  # 防止XSS攻击\n  xss:\n    enabled: true\n    excludeUrls:\n      - /system/notice\n  # 不校验白名单\n  ignore:\n    whites:\n      - /auth/logout\n      - /auth/login\n      - /auth/refreshRedis\n      - /auth/register\n      - /*/v2/api-docs\n      - /csrf\n      - /profile/**\n      # 以下为首页免登过滤接口\n      - /system/user/getInfo\n      - /project/statistics\n      - /project/doing\n      - /project/queryMyTaskList\n      - /project/select\n      - /system/menu/getRouters\n\n', '21ecfc91242854b41d0131eef9903b61', '2020-05-14 14:17:55', '2024-05-23 14:25:02', NULL, '0:0:0:0:0:0:0:1', '', '', '网关模块', 'null', 'null', 'yaml', '', '');
INSERT INTO `pmhub-nacos`.`config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`, `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`, `encrypted_data_key`) VALUES (3, 'pmhub-auth-dev.yml', 'DEFAULT_GROUP', 'spring:\n  redis:\n    host: localhost\n    port: 6379\n    password:\n', '8bd9dada9a94822feeab40de55efced6', '2020-11-20 00:00:00', '2022-09-29 02:48:42', 'nacos', '0:0:0:0:0:0:0:1', '', '', '认证中心', 'null', 'null', 'yaml', '', '');
INSERT INTO `pmhub-nacos`.`config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`, `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`, `encrypted_data_key`) VALUES (4, 'pmhub-monitor-dev.yml', 'DEFAULT_GROUP', '# spring\nspring:\n  security:\n    user:\n      name: admin\n      password: 123456\n  boot:\n    admin:\n      ui:\n        title: PmHub服务状态监控\n', 'de1450aa0e9308890616af7a5c5b0784', '2020-11-20 00:00:00', '2024-05-16 09:14:57', NULL, '0:0:0:0:0:0:0:1', '', '', '监控中心', 'null', 'null', 'yaml', '', '');
INSERT INTO `pmhub-nacos`.`config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`, `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`, `encrypted_data_key`) VALUES (5, 'pmhub-system-dev.yml', 'DEFAULT_GROUP', '# spring配置\nspring:\n  # 数据源配置\n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    driverClassName: com.mysql.cj.jdbc.Driver\n    druid:\n      # 主库数据源\n      master:\n        url: jdbc:mysql://127.0.0.1:3306/laigeoffer-pmhub?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n        username: root\n        password: 123456\n      # 从库数据源\n      slave:\n        # 从数据源开关/默认关闭\n        enabled: false\n        url:\n        username:\n        password:\n      # 初始连接数\n      initialSize: 5\n      # 最小连接池数量\n      minIdle: 10\n      # 最大连接池数量\n      maxActive: 20\n      # 配置获取连接等待超时的时间\n      maxWait: 60000\n      # 配置间隔多久才进行一次检测，检测需要关闭的空闲连接，单位是毫秒\n      timeBetweenEvictionRunsMillis: 60000\n      # 配置一个连接在池中最小生存的时间，单位是毫秒\n      minEvictableIdleTimeMillis: 300000\n      # 配置一个连接在池中最大生存的时间，单位是毫秒\n      maxEvictableIdleTimeMillis: 900000\n      # 配置检测连接是否有效\n      validationQuery: SELECT 1 FROM DUAL\n      testWhileIdle: true\n      testOnBorrow: false\n      testOnReturn: false\n      webStatFilter:\n        enabled: true\n      statViewServlet:\n        enabled: true\n        reset-enable: false\n        url-pattern: /druid/*\n\n      filter:\n        stat:\n          enabled: true\n          # 慢SQL记录\n          log-slow-sql: true\n          slow-sql-millis: 3000\n          merge-sql: true\n        wall:\n          config:\n            multi-statement-allow: true\n\n  # redis 配置\n  redis:\n    # 地址\n    host: 127.0.0.1\n    # 端口，默认为6379\n    port: 6379\n    # 数据库索引\n    database: 0\n    # 密码\n    password:\n    # 连接超时时间\n    timeout: 10s\n    lettuce:\n      pool:\n        # 连接池中的最小空闲连接\n        min-idle: 0\n        # 连接池中的最大空闲连接\n        max-idle: 8\n        # 连接池的最大数据库连接数\n        max-active: 8\n        # #连接池最大阻塞等待时间（使用负值表示没有限制）\n        max-wait: -1ms\n\n# mybatis配置\n# mybatis:\n#     # 搜索指定包别名\n#     typeAliasesPackage: com.laigeoffer.pmhub.system\n#     # 配置mapper的扫描，找到所有的mapper.xml映射文件\n#     mapperLocations: classpath:mapper/**/*.xml\n\n# MyBatis-plus 配置\n# mybatis-plus:\n#   # 搜索指定包别名\n#   typeAliasesPackage: com.laigeoffer.pmhub.system\n#   # 配置mapper的扫描，找到所有的mapper.xml映射文件\n#   mapperLocations: classpath:mapper/**/*Mapper.xml\n#   # 加载全局的配置文件\n#   configLocation: classpath:mybatis/mybatis-config.xml\n\n\n# 自定义参数\npmhub:\n  # 本地上传路径，这里使用的是相对路径，请修改为你自己需要设置的上传路径\n  profile: ./upload\n\n# 日志配置\nlogging:\n  level:\n    com.laigeoffer.pmhub: info\n    org.springframework: warn\n  # 日志路径配置：测试及线上环境请勿修改保证 path: /data/logs 始终是这个 因为容器部署挂载的这个路径，本地环境可修改自己的存储路径\n  file:\n    path: ./logs/laigeoffer/pmhub/\n      \n\n# swagger配置\nswagger:\n  title: 系统模块接口文档\n  license: Powered By canghe\n  licenseUrl: https://canghecode.com', '9b26f83c90cd0c2ca6c9371c8756cba6', '2020-11-20 00:00:00', '2024-04-26 07:31:06', NULL, '0:0:0:0:0:0:0:1', '', '', '系统模块', 'null', 'null', 'yaml', '', '');
INSERT INTO `pmhub-nacos`.`config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`, `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`, `encrypted_data_key`) VALUES (6, 'pmhub-gen-dev.yml', 'DEFAULT_GROUP', '# spring配置\nspring:\n  # 数据源配置\n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    driverClassName: com.mysql.cj.jdbc.Driver\n    druid:\n      # 主库数据源\n      master:\n        url: jdbc:mysql://127.0.0.1:3306/laigeoffer-pmhub?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n        username: root\n        password: 123456\n      # 从库数据源\n      slave:\n        # 从数据源开关/默认关闭\n        enabled: false\n        url:\n        username:\n        password:\n      # 初始连接数\n      initialSize: 5\n      # 最小连接池数量\n      minIdle: 10\n      # 最大连接池数量\n      maxActive: 20\n      # 配置获取连接等待超时的时间\n      maxWait: 60000\n      # 配置间隔多久才进行一次检测，检测需要关闭的空闲连接，单位是毫秒\n      timeBetweenEvictionRunsMillis: 60000\n      # 配置一个连接在池中最小生存的时间，单位是毫秒\n      minEvictableIdleTimeMillis: 300000\n      # 配置一个连接在池中最大生存的时间，单位是毫秒\n      maxEvictableIdleTimeMillis: 900000\n      # 配置检测连接是否有效\n      validationQuery: SELECT 1 FROM DUAL\n      testWhileIdle: true\n      testOnBorrow: false\n      testOnReturn: false\n      webStatFilter:\n        enabled: true\n      statViewServlet:\n        enabled: true\n        reset-enable: false\n        url-pattern: /druid/*\n\n      filter:\n        stat:\n          enabled: true\n          # 慢SQL记录\n          log-slow-sql: true\n          slow-sql-millis: 3000\n          merge-sql: true\n        wall:\n          config:\n            multi-statement-allow: true\n\n  # redis 配置\n  redis:\n    # 地址\n    host: 127.0.0.1\n    # 端口，默认为6379\n    port: 6379\n    # 数据库索引\n    database: 0\n    # 密码\n    password:\n    # 连接超时时间\n    timeout: 10s\n    lettuce:\n      pool:\n        # 连接池中的最小空闲连接\n        min-idle: 0\n        # 连接池中的最大空闲连接\n        max-idle: 8\n        # 连接池的最大数据库连接数\n        max-active: 8\n        # #连接池最大阻塞等待时间（使用负值表示没有限制）\n        max-wait: -1ms\n\n\n# mybatis配置\n# mybatis:\n#     # 搜索指定包别名\n#     typeAliasesPackage: com.laigeoffer.pmhub.gen.domain\n#     # 配置mapper的扫描，找到所有的mapper.xml映射文件\n#     mapperLocations: classpath:mapper/**/*.xml\n\n\n\n# swagger配置\nswagger:\n  title: 代码生成接口文档\n  license: Powered By canghe\n  licenseUrl: https://canghecode.com\n\n# 代码生成\ngen:\n  # 作者\n  author: canghe\n  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool\n  packageName: com.laigeoffer.pmhub.system\n  # 自动去除表前缀，默认是false\n  autoRemovePre: false\n  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）\n  tablePrefix: sys_\n', '690fbe58b66111210660708519ca859d', '2020-11-20 00:00:00', '2024-04-28 01:39:01', NULL, '0:0:0:0:0:0:0:1', '', '', '代码生成', 'null', 'null', 'yaml', '', '');
INSERT INTO `pmhub-nacos`.`config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`, `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`, `encrypted_data_key`) VALUES (7, 'pmhub-job-dev.yml', 'DEFAULT_GROUP', '# spring配置\nspring:\n  # 数据源配置\n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    driverClassName: com.mysql.cj.jdbc.Driver\n    druid:\n      # 主库数据源\n      master:\n        url: jdbc:mysql://127.0.0.1:3306/laigeoffer-pmhub?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n        username: root\n        password: 123456\n      # 从库数据源\n      slave:\n        # 从数据源开关/默认关闭\n        enabled: false\n        url:\n        username:\n        password:\n      # 初始连接数\n      initialSize: 5\n      # 最小连接池数量\n      minIdle: 10\n      # 最大连接池数量\n      maxActive: 20\n      # 配置获取连接等待超时的时间\n      maxWait: 60000\n      # 配置间隔多久才进行一次检测，检测需要关闭的空闲连接，单位是毫秒\n      timeBetweenEvictionRunsMillis: 60000\n      # 配置一个连接在池中最小生存的时间，单位是毫秒\n      minEvictableIdleTimeMillis: 300000\n      # 配置一个连接在池中最大生存的时间，单位是毫秒\n      maxEvictableIdleTimeMillis: 900000\n      # 配置检测连接是否有效\n      validationQuery: SELECT 1 FROM DUAL\n      testWhileIdle: true\n      testOnBorrow: false\n      testOnReturn: false\n      webStatFilter:\n        enabled: true\n      statViewServlet:\n        enabled: true\n        reset-enable: false\n        url-pattern: /druid/*\n\n      filter:\n        stat:\n          enabled: true\n          # 慢SQL记录\n          log-slow-sql: true\n          slow-sql-millis: 3000\n          merge-sql: true\n        wall:\n          config:\n            multi-statement-allow: true\n\n  # redis 配置\n  redis:\n    # 地址\n    host: 127.0.0.1\n    # 端口，默认为6379\n    port: 6379\n    # 数据库索引\n    database: 0\n    # 密码\n    password:\n    # 连接超时时间\n    timeout: 10s\n    lettuce:\n      pool:\n        # 连接池中的最小空闲连接\n        min-idle: 0\n        # 连接池中的最大空闲连接\n        max-idle: 8\n        # 连接池的最大数据库连接数\n        max-active: 8\n        # #连接池最大阻塞等待时间（使用负值表示没有限制）\n        max-wait: -1ms\n\n\n# swagger配置\nswagger:\n  title: 定时任务接口文档\n  license: Powered By canghe\n  licenseUrl: https://canghecode.com\n', '132c6d2cadceb9bbbdf624757499a582', '2020-11-20 00:00:00', '2024-04-28 01:51:46', NULL, '0:0:0:0:0:0:0:1', '', '', '定时任务', 'null', 'null', 'yaml', '', '');
INSERT INTO `pmhub-nacos`.`config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`, `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`, `encrypted_data_key`) VALUES (9, 'sentinel-pmhub-gateway', 'DEFAULT_GROUP', '[\n    {\n        \"resource\": \"pmhub-auth\",\n        \"count\": 500,\n        \"grade\": 1,\n        \"limitApp\": \"default\",\n        \"strategy\": 0,\n        \"controlBehavior\": 0\n    },\n	{\n        \"resource\": \"pmhub-system\",\n        \"count\": 1000,\n        \"grade\": 1,\n        \"limitApp\": \"default\",\n        \"strategy\": 0,\n        \"controlBehavior\": 0\n    },\n	{\n        \"resource\": \"pmhub-gen\",\n        \"count\": 200,\n        \"grade\": 1,\n        \"limitApp\": \"default\",\n        \"strategy\": 0,\n        \"controlBehavior\": 0\n    },\n	{\n        \"resource\": \"pmhub-job\",\n        \"count\": 300,\n        \"grade\": 1,\n        \"limitApp\": \"default\",\n        \"strategy\": 0,\n        \"controlBehavior\": 0\n    }\n]', '1313ff702c74b0172c0dcddfaace75d8', '2020-11-20 00:00:00', '2024-04-25 13:16:56', NULL, '0:0:0:0:0:0:0:1', '', '', '限流策略', 'null', 'null', 'json', '', '');
INSERT INTO `pmhub-nacos`.`config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`, `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`, `encrypted_data_key`) VALUES (32, 'pmhub-project-dev.yml', 'DEFAULT_GROUP', '# spring配置\nspring:\n  # 数据源配置\n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    driverClassName: com.mysql.cj.jdbc.Driver\n    druid:\n      # 主库数据源\n      master:\n        url: jdbc:mysql://127.0.0.1:3306/laigeoffer-pmhub?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n        username: root\n        password: 123456\n      # 从库数据源\n      slave:\n        # 从数据源开关/默认关闭\n        enabled: false\n        url:\n        username:\n        password:\n      # 初始连接数\n      initialSize: 5\n      # 最小连接池数量\n      minIdle: 10\n      # 最大连接池数量\n      maxActive: 20\n      # 配置获取连接等待超时的时间\n      maxWait: 60000\n      # 配置间隔多久才进行一次检测，检测需要关闭的空闲连接，单位是毫秒\n      timeBetweenEvictionRunsMillis: 60000\n      # 配置一个连接在池中最小生存的时间，单位是毫秒\n      minEvictableIdleTimeMillis: 300000\n      # 配置一个连接在池中最大生存的时间，单位是毫秒\n      maxEvictableIdleTimeMillis: 900000\n      # 配置检测连接是否有效\n      validationQuery: SELECT 1 FROM DUAL\n      testWhileIdle: true\n      testOnBorrow: false\n      testOnReturn: false\n      webStatFilter:\n        enabled: true\n      statViewServlet:\n        enabled: true\n        reset-enable: false\n        url-pattern: /druid/*\n\n      filter:\n        stat:\n          enabled: true\n          # 慢SQL记录\n          log-slow-sql: true\n          slow-sql-millis: 3000\n          merge-sql: true\n        wall:\n          config:\n            multi-statement-allow: true\n\n  # redis 配置\n  redis:\n    # 地址\n    host: 127.0.0.1\n    # 端口，默认为6379\n    port: 6379\n    # 数据库索引\n    database: 0\n    # 密码\n    password:\n    # 连接超时时间\n    timeout: 10s\n    lettuce:\n      pool:\n        # 连接池中的最小空闲连接\n        min-idle: 0\n        # 连接池中的最大空闲连接\n        max-idle: 8\n        # 连接池的最大数据库连接数\n        max-active: 8\n        # #连接池最大阻塞等待时间（使用负值表示没有限制）\n        max-wait: -1ms', '8e4e7845067111d19b93438bc54f6096', '2024-04-28 02:51:12', '2024-04-28 02:51:12', NULL, '0:0:0:0:0:0:0:1', '', '', '项目管理', NULL, NULL, 'yaml', NULL, '');
INSERT INTO `pmhub-nacos`.`config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`, `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`, `encrypted_data_key`) VALUES (33, 'pmhub-workflow-dev.yml', 'DEFAULT_GROUP', '# spring配置\nspring:\n  # 数据源配置\n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    driverClassName: com.mysql.cj.jdbc.Driver\n    druid:\n      # 主库数据源\n      master:\n        url: jdbc:mysql://127.0.0.1:3306/laigeoffer-pmhub?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n        username: root\n        password: 123456\n      # 从库数据源\n      slave:\n        # 从数据源开关/默认关闭\n        enabled: false\n        url:\n        username:\n        password:\n      # 初始连接数\n      initialSize: 5\n      # 最小连接池数量\n      minIdle: 10\n      # 最大连接池数量\n      maxActive: 20\n      # 配置获取连接等待超时的时间\n      maxWait: 60000\n      # 配置间隔多久才进行一次检测，检测需要关闭的空闲连接，单位是毫秒\n      timeBetweenEvictionRunsMillis: 60000\n      # 配置一个连接在池中最小生存的时间，单位是毫秒\n      minEvictableIdleTimeMillis: 300000\n      # 配置一个连接在池中最大生存的时间，单位是毫秒\n      maxEvictableIdleTimeMillis: 900000\n      # 配置检测连接是否有效\n      validationQuery: SELECT 1 FROM DUAL\n      testWhileIdle: true\n      testOnBorrow: false\n      testOnReturn: false\n      webStatFilter:\n        enabled: true\n      statViewServlet:\n        enabled: true\n        reset-enable: false\n        url-pattern: /druid/*\n\n      filter:\n        stat:\n          enabled: true\n          # 慢SQL记录\n          log-slow-sql: true\n          slow-sql-millis: 3000\n          merge-sql: true\n        wall:\n          config:\n            multi-statement-allow: true\n\n  # redis 配置\n  redis:\n    # 地址\n    host: 127.0.0.1\n    # 端口，默认为6379\n    port: 6379\n    # 数据库索引\n    database: 0\n    # 密码\n    password:\n    # 连接超时时间\n    timeout: 10s\n    lettuce:\n      pool:\n        # 连接池中的最小空闲连接\n        min-idle: 0\n        # 连接池中的最大空闲连接\n        max-idle: 8\n        # 连接池的最大数据库连接数\n        max-active: 8\n        # #连接池最大阻塞等待时间（使用负值表示没有限制）\n        max-wait: -1ms\n\n\n        ', '6555f794c10269ba16fea62771a383ee', '2024-04-28 03:51:49', '2024-05-06 15:52:47', NULL, '0:0:0:0:0:0:0:1', '', '', '流程管理服务', '', '', 'yaml', '', '');

/******************************************/
/*   表名称 = config_info_aggr   */
/******************************************/
CREATE TABLE `config_info_aggr` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) NOT NULL COMMENT 'datum_id',
  `content` longtext NOT NULL COMMENT '内容',
  `gmt_modified` datetime NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) DEFAULT NULL,
  `tenant_id` varchar(128) DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfoaggr_datagrouptenantdatum` (`data_id`,`group_id`,`tenant_id`,`datum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='增加租户字段';


/******************************************/
/*   表名称 = config_info_beta   */
/******************************************/
CREATE TABLE `config_info_beta` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) DEFAULT NULL COMMENT 'app_name',
  `content` longtext NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text COMMENT 'source user',
  `src_ip` varchar(50) DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` text COMMENT '秘钥',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfobeta_datagrouptenant` (`data_id`,`group_id`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info_beta';

/******************************************/
/*   表名称 = config_info_tag   */
/******************************************/
CREATE TABLE `config_info_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) DEFAULT NULL COMMENT 'app_name',
  `content` longtext NOT NULL COMMENT 'content',
  `md5` varchar(32) DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text COMMENT 'source user',
  `src_ip` varchar(50) DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfotag_datagrouptenanttag` (`data_id`,`group_id`,`tenant_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info_tag';

/******************************************/
/*   表名称 = config_tags_relation   */
/******************************************/
CREATE TABLE `config_tags_relation` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `tag_name` varchar(128) NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nid`),
  UNIQUE KEY `uk_configtagrelation_configidtag` (`id`,`tag_name`,`tag_type`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_tag_relation';

/******************************************/
/*   表名称 = group_capacity   */
/******************************************/
CREATE TABLE `group_capacity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  `usage` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `max_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='集群、各Group容量信息表';

/******************************************/
/*   表名称 = his_config_info   */
/******************************************/
CREATE TABLE `his_config_info` (
  `id` bigint(64) unsigned NOT NULL,
  `nid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `data_id` varchar(255) NOT NULL,
  `group_id` varchar(128) NOT NULL,
  `app_name` varchar(128) DEFAULT NULL COMMENT 'app_name',
  `content` longtext NOT NULL,
  `md5` varchar(32) DEFAULT NULL,
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `src_user` text,
  `src_ip` varchar(50) DEFAULT NULL,
  `op_type` char(10) DEFAULT NULL,
  `tenant_id` varchar(128) DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` text COMMENT '秘钥',
  PRIMARY KEY (`nid`),
  KEY `idx_gmt_create` (`gmt_create`),
  KEY `idx_gmt_modified` (`gmt_modified`),
  KEY `idx_did` (`data_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='多租户改造';


/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = tenant_capacity   */
/******************************************/
CREATE TABLE `tenant_capacity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  `usage` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `max_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数',
  `max_aggr_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='租户容量信息表';


CREATE TABLE `tenant_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) default '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) default '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint(20) NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint(20) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tenant_info_kptenantid` (`kp`,`tenant_id`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='tenant_info';

CREATE TABLE `users` (
	`username` varchar(50) NOT NULL PRIMARY KEY,
	`password` varchar(500) NOT NULL,
	`enabled` boolean NOT NULL
);

CREATE TABLE `roles` (
	`username` varchar(50) NOT NULL,
	`role` varchar(50) NOT NULL,
	UNIQUE INDEX `idx_user_role` (`username` ASC, `role` ASC) USING BTREE
);

CREATE TABLE `permissions` (
    `role` varchar(50) NOT NULL,
    `resource` varchar(255) NOT NULL,
    `action` varchar(8) NOT NULL,
    UNIQUE INDEX `uk_role_permission` (`role`,`resource`,`action`) USING BTREE
);

INSERT INTO users (username, password, enabled) VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', TRUE);

INSERT INTO roles (username, role) VALUES ('nacos', 'ROLE_ADMIN');