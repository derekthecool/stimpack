---@diagnostic disable: undefined-global, missing-parameter

-- This whole snippet file is for ESP32 microcontroller code

local auxiliary = require('luasnippets.functions.auxiliary')
local shareable = require('luasnippets.functions.shareable_snippets')

local snippets = {

    ms(
        {
            { trig = 'ESP32_cpp_thread', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
    #include "esp_pthread.h"

    esp_pthread_cfg_t cfg = esp_pthread_get_default_config();
    cfg.stack_size = (9 * 1024); // 5K default
    cfg.thread_name = "OTASimSwapThread";
    esp_pthread_set_cfg(&cfg);

    try
    {
        thread t([this]() {
            <Code>
        });
        t.detach();
    }
    catch (const std::system_error &e)
    {
        ESP_LOGE(TAG, "[%s] Failed to start thread: %s", __FUNCTION__, e.what());
        abort();
    }
    catch (...)
    {
        ESP_LOGE(TAG, "[%s] Unknown exception starting thread", __FUNCTION__);
    }
        ]],
            {
                Code = i(1),
            },
            { delimiters = '<>' }
        )
    ),

    ms({
        { trig = 'esp_err_t', snippetType = 'snippet', condition = nil },
        { trig = 'esp error', snippetType = 'autosnippet', condition = nil },
    }, fmt([[esp_err_t]], {})),

    ms(
        {
            { trig = 'esp_err_to_name', snippetType = 'snippet', condition = nil },
            { trig = 'esp string', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        esp_err_to_name({esp_err_t_value})
        ]],
            {
                esp_err_t_value = i(1, 'esp_err_t_value'),
            }
        )
    ),
    ms({
        { trig = 'esp okay', snippetType = 'autosnippet', condition = nil },
        { trig = 'ESP_OK', snippetType = 'autosnippet', condition = nil },
    }, fmt([[ESP_OK]], {})),
    ms({
        { trig = 'esp fail', snippetType = 'autosnippet', condition = nil },
        { trig = 'ESP_FAIL', snippetType = 'autosnippet', condition = nil },
    }, fmt([[ESP_FAIL]], {})),

    ms(
        {
            { trig = 'ESP32_cli_argtable_args', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
    // Move some where more accessible
    static struct
    {
        arg_str_t *<struct_item>;
        arg_end_t *end;
    } <struct_name>;

    int nerrors = arg_parse(argc, argv, (void **)&<rep_struct_name>);
    if (nerrors != 0)
    {
        arg_print_errors(stderr, <rep_struct_name>.end, argv[0]);
        return 0;
    }

    // Move to setup function
    <rep_struct_name>.<struct_item_rep> =
        arg_str0("m", "message", "data type", "MQTT topics to subscribe to (up to 100 items)");
        ]],
            {
                struct_name = i(1, 'my_struct'),
                struct_item = i(2, 'string_arg'),
                rep_struct_name = rep(1),
                struct_item_rep = rep(2),
            },
            { delimiters = '<>' }
        )
    ),

    ms(
        {
            { trig = 'console_function', snippetType = 'snippet', condition = conds.line_begin },
            { trig = 'ESP32_cli', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
        // ***START***************** <FunctionNameRep> command ********************************
        static esp_err_t do_<FunctionName>_cmd(int argc, char** argv)
        {
            // Function to expose to ESP32 console
            <ExposedCommand>

            // Print result of command
            <PrintOutput>

            // Return value
            return ESP_OK;
        }

        static void register_<FunctionNameRep>(void)
        {
            const esp_console_cmd_t <FunctionNameRep>_args = {
                .command = "<FunctionNameRep>",
                .help = "<HelpText>",
                .hint = NULL,
                .func = &do_<FunctionNameRep>_cmd
            };
            ESP_ERROR_CHECK(esp_console_cmd_register(&<FunctionNameRep>_args));
        }
        // ***END******************* <FunctionNameRep> command ********************************
        ]],
            {
                FunctionName = i(1, 'console_command_name'),
                FunctionNameRep = rep(1),
                ExposedCommand = i(2, 'command_to_expose_here()'),
                PrintOutput = i(3, 'printf("Print some output here");'),
                HelpText = i(4, 'This function does something great to use it ....'),
            },
            {
                delimiters = '<>',
            }
        )
    ),

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
        {
            {
                trig = 'ESP32register_console_command',
                snippetType = 'snippet',
            },
        },
        fmt(
            [[
        const esp_console_cmd_t {} = {{
            .command = "{}",
            .help = "{}\n",
            .hint = NULL,
            .func = {},
        }};
        ESP_ERROR_CHECK(esp_console_cmd_register(&{}));
        ]],
            {
                i(1, 'command'),
                i(2, 'command to type at console'),
                i(3, 'This command does something really awesome'),
                i(4, 'function_to_map_to'),
                rep(1),
            }
        )
    ),

    ms(
        {
            { trig = 'ESP32log', snippetType = 'snippet', condition = nil },
            { trig = 'ESP32 ESP32', snippetType = 'autosnippet', condition = nil },
        },
        fmt([[ESP_LOG{}({}, "{}"{});]], {
            c(1, {
                t('I'),
                t('D'),
                t('W'),
                t('E'),
                t('V'),
            }),
            i(2, 'TAG'),
            i(3),
            auxiliary.printf_style_dynamic_formatter(4, 3),
        }),
        {
            callbacks = {
                [-1] = {
                    [events.pre_expand] = function()
                        auxiliary.insert_include_if_needed('"esp_log.h"')
                    end,
                },
            },
        }
    ),
    ms(
        {
            {
                trig = 'esp_log_level_set',
                snippetType = 'snippet',
            },
            {
                trig = 'ESP32setloglevel',
                snippetType = 'snippet',
            },
        },
        fmt(
            [[
        esp_log_level_set("{}", {});
        ]],
            {
                i(1, 'logging_source'),
                c(2, {
                    t('ESP_LOG_DEBUG'),
                    t('ESP_LOG_ERROR'),
                    t('ESP_LOG_WARN'),
                    t('ESP_LOG_INFO'),
                    t('ESP_LOG_VERBOSE'),
                    t('ESP_LOG_NONE'),
                }),
            }
        )
    ),
    s(
        'ESP32errorcheck',
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

    -- FreeRTOS snippets
    -- Needs #include "freertos/task.h"
    s(
        'FreeRTOS_task_create',
        -- // static inline BaseType_t xTaskCreate(TaskFunction_t pxTaskCode, const char *const pcName, const configSTACK_DEPTH_TYPE usStackDepth, void *const pvParameters, UBaseType_t uxPriority, TaskHandle_t *const pxCreatedTask)
        -- // static inline TaskHandle_t xTaskCreateStatic(TaskFunction_t pxTaskCode, const char *const pcName, const uint32_t ulStackDepth, void *const pvParameters, UBaseType_t uxPriority, StackType_t *const puxStackBuffer, StaticTask_t *const pxTaskBuffer)
        fmt(
            [[
        xTaskCreate({}, {}, {}, {}, {}, {});
        ]],
            {
                i(1, 'TaskFunction_t pxTaskCode'),
                i(2, 'const char *const pcName'),
                i(3, 'const configSTACK_DEPTH_TYPE usStackDepth'),
                i(4, 'void *const pvParameters'),
                i(5, 'UBaseType_t uxPriority'),
                i(6, 'TaskHandle_t *const pxCreatedTask'),
            }
        )
    ),

    -- Needs #include "freertos/task.h"
    s(
        'FreeRTOS_task_delay',
        fmt(
            [[
        // Consider using the function: xTaskDelayUntil(TickType_t *const pxPreviousWakeTime, const TickType_t xTimeIncrement)
        vTaskDelay({} / portTICK_PERIOD_MS);
        ]],
            {
                i(1, '1000'),
            }
        )
    ),

    -- Needs #include "freertos/task.h"
    s(
        'FreeRTOS_task_delete',
        fmt(
            [[
        vTaskDelete({});
        ]],
            {
                i(1, 'task_handle'),
            }
        )
    ),

    ms(
        {
            { trig = 'uxQueueMessagesWaiting', snippetType = 'snippet' },
            { trig = 'FreeRTOS_queue_messages_waiting', snippetType = 'snippet' },
        },
        fmt(
            [[
        int {} = uxQueueMessagesWaiting({});
        ]],
            {
                i(1, 'queued_messages'),
                i(1, 'queue'),
            }
        )
    ),

    s(
        'FreeRTOS_queue_read',
        fmt(
            [[
        // xTicksToWait sets the time to wait for a queue item, 0 returns immediately
        // Return value of 0 means nothing in the queue changed, 1 means it has changed
        xQueueReceive({}, &{}, (TickType_t){});
        ]],
            {
                i(1, 'queue'),
                i(2, 'variable_to_copy_queue_values'),
                i(3, 'xTicksToWait'),
            }
        ),
        {
            callbacks = {
                [-1] = {
                    [events.pre_expand] = function()
                        auxiliary.insert_include_if_needed({ '<freertos/FreeRTOS.h>', '<freertos/queue.h>' })
                    end,
                },
            },
        }
    ),

    s(
        'FreeRTOS_queue_send',
        fmt(
            [[
        xQueueSend({}, {}, {});
        ]],
            {
                i(1, 'queue'),
                i(2, 'pointer_to_queue'),
                i(3, 'xTicksToWait'),
            }
        ),
        {
            callbacks = {
                [-1] = {
                    [events.pre_expand] = function()
                        auxiliary.insert_include_if_needed({ '<freertos/FreeRTOS.h>', '<freertos/queue.h>' })
                    end,
                },
            },
        }
    ),

    s(
        'FreeRTOS_queue_create',
        fmt(
            [[
            {} xQueueCreate({}, {});
        ]],
            {
                i(1, 'QueueHandle_t queue'),
                i(2, 'length'),
                i(3, 'size_of_each'),
            }
        ),
        {
            callbacks = {
                [-1] = {
                    [events.pre_expand] = function()
                        auxiliary.insert_include_if_needed({ '<freertos/FreeRTOS.h>', '<freertos/queue.h>' })
                    end,
                },
            },
        }
    ),
}

local autosnippets = {}

return snippets, autosnippets
