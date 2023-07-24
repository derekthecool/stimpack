---@diagnostic disable: undefined-global, missing-parameter

-- This whole snippet file is for ESP32 microcontroller code

local snippets = {

    s(
        'ESP32interrupt',
        fmt(
            [[

#define INTERRUPT_INPUT_PIN 23
#define ESP_INTR_FLAG_DEFAULT 0

TaskHandle_t ISR = NULL;

void IRAM_ATTR button_isr_handler(void *arg) {{ xTaskResumeFromISR(ISR); }}

void button_task(void *arg) {{
  while (true) {{
    ESP_LOGI("interrupt", "interrupt hit");
    RegularSensorRead();
    vTaskSuspend(NULL);
  }}
}}

  void app_main(void) {{
      // Setup hardware interrupt for PPG ADC ready
      gpio_set_direction(INTERRUPT_INPUT_PIN, GPIO_MODE_INPUT);
      gpio_set_intr_type(INTERRUPT_INPUT_PIN, GPIO_INTR_HIGH_LEVEL);
      gpio_install_isr_service(ESP_INTR_FLAG_DEFAULT);
      gpio_isr_handler_add(INTERRUPT_INPUT_PIN, button_isr_handler, NULL);
      xTaskCreate(button_task, "button_task", 4096, NULL, 10, &ISR);
  }}
        ]],
            {}
        )
    ),

    ms(
        { 'ESP32log', 'ESP_LOGE' },
        fmt([[ESP_LOG{}({}, "{}"{});]], {
            c(1, {
                t('E'),
                t('W'),
                t('I'),
                t('D'),
                t('V'),
            }),
            i(2, 'TAG'),
            i(3),
            d(4, function(args, snip)
                local nodes = {}

                -- Add nodes for snippet
                -- table.insert(nodes, t('Add this node'))
                local text = args[1][1]
                if text then
                    local _, length = text:gsub('%%', '')
                    if length and length > 0 then
                        for i = 1, length do
                            table.insert(nodes, t(','))
                            table.insert(nodes, i(1))
                        end
                    end
                end

                return sn(nil, nodes)
            end, { 3 }),
        })
    ),
    s(
        'ESP32error',
        fmt(
            [[
      ESP_ERROR_CHECK({});
      ]],
            { i(1) }
        )
    ),
    s(
        'ESP32ledc',
        fmt(
            [[
            // https://esp32.com/viewtopic.php?t=23940
            static void ledc_init(void) {{
              ledc_timer_config_t ledc_timer = {{
                  .speed_mode = LEDC_HIGH_SPEED_MODE,
                  .timer_num = LEDC_TIMER_0,
                  .duty_resolution = LEDC_TIMER_1_BIT,
                  .freq_hz = 8000000,
                  .clk_cfg = LEDC_USE_APB_CLK,
              }};

              ESP_ERROR_CHECK(ledc_timer_config(&ledc_timer));

              ledc_channel_config_t ledc_channel = {{
                  .speed_mode = LEDC_HIGH_SPEED_MODE,
                  .channel = LEDC_CHANNEL_0,
                  .timer_sel = LEDC_TIMER_0,
                  .intr_type = LEDC_INTR_DISABLE,
                  .gpio_num = 0,
                  .duty = 1,
                  .hpoint = 0,
              }};

              ESP_ERROR_CHECK(ledc_channel_config(&ledc_channel));
        }}
        ]],
            {}
        )
    ),
}

local autosnippets = {}

return snippets, autosnippets
