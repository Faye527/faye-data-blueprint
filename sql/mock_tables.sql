| 表名                    | 说明              | 主键                                  | 用途                       |
| --------------------- | -----------        | ----------------------------------- | ------------------------ |
| `dim_users`           | 用户注册信息（维度表） | `user_id`                           | 注册渠道、设备、注册时间等            |
| `dwd_user_action_log` | 用户行为日志（明细表） | `(user_id, event_time, event_name)` | 分析活跃、激活、浏览、加购、留存等        |
| `dwd_orders`          | 订单明细             | `order_id`                          | 交易金额、时间、用户               |
| `dwd_ad_clicks`       | 广告点击表           | `(user_id, click_time)`             | 做渠道 attribution 或 AB实验时用 |
| `dim_date`            | 时间维度表（可选）    | `date`                              | 做留存、DAU、趋势图等更好用          |

CREATE TABLE dim_users (
    user_id INT PRIMARY KEY,
    signup_time TIMESTAMP,
    channel STRING,             -- organic / paid / referral
    device_type STRING,         -- iOS / Android / Web
    country STRING,
    is_robot BOOLEAN DEFAULT FALSE
);
CREATE TABLE dwd_user_action_log (
    user_id INT,
    event_time TIMESTAMP,
    event_name STRING,         -- 'login', 'view_item', 'add_to_cart', 'purchase'
    page_id STRING,            -- 页面ID（可用于跳出率等分析）
    session_id STRING,
    platform STRING,           -- Web / App
    device_type STRING
);
CREATE TABLE dwd_orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_time TIMESTAMP,
    amount FLOAT,
    is_first_order BOOLEAN,
    order_status STRING        -- success / failed / refund
);
CREATE TABLE dwd_ad_clicks (
    user_id INT,
    ad_id STRING,
    click_time TIMESTAMP,
    campaign STRING,
    platform STRING
);
CREATE TABLE dim_date (
    date DATE PRIMARY KEY,
    is_weekend BOOLEAN,
    is_holiday BOOLEAN,
    week_num INT,
    month INT,
    year INT
);
