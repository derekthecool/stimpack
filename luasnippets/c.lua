---@diagnostic disable: undefined-global

local my_treesitter_functions = require('stimpack.my-treesitter-functions')

local snippets = {

    -- {{{ clang format disable block
    s(
        {
            trig = 'clangf',
            descr = 'Comment string to disable clang formatting',
        },
        fmt(
            [[
      // clang-format off
      {}
      // clang-format on
      ]],
            { i(1) }
        )
    ),
    -- }}}

    -- {{{ easy strtok
    s(
        {
            trig = 'strtok_ez',
            descr = 'Easily use strtok with a for loop',
        },
        fmt(
            [[
      for (char *p = strtok({}, ","); p != NULL; p = strtok(NULL, ","))
      {{
        returnValue += atoi(p);
      }}
      {}
      ]],
            { i(1, 'InputStringToParse'), i(2) }
        )
    ),
    -- }}}

    -- ESP32 snippets
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
        'ESP32log',
        fmt(
            [[
      ESP_LOGI({});
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

    s(
        'macro stringize',
        fmt(
            [[
        #define Stringize(x) #x
        ]],
            {}
        )
    ),

    s(
        'macro double stringize',
        fmt(
            [[
        #define Stringize(x) #x
        #define DoubleStringize(x) Stringize(x)
        ]],
            {}
        )
    ),
}

local autosnippets = {

    s(
        'FOR',
        fmt(
            [[
        for(int i = {}; i < {}; i{})
        {{
            {}
        }}
        ]],
            {
                i(1, '0'),
                i(2, '10'),
                c(3, {
                    t('++'),
                    t('--'),
                }),
                i(4),
            }
        )
    ),

    s(
        'IF',
        fmt(
            [[
        if({})
        {{
            {}
        }}{}
        ]],
            {
                i(1),
                i(2),
                i(0),
            }
        )
    ),

    s(
        'ELSE',
        fmt(
            [[
        else
        {{
            {}
        }}{}
        ]],
            {
                i(1),
                i(0),
            }
        )
    ),

    s(
        'var var',
        fmt(
            [[
      {}
      ]],
            {
                f(function()
                    local variable = my_treesitter_functions.cs.get_recent_var()
                    return variable
                end, {}),
            }
        )
    ),

    s(
        'FUNCTION',
        fmt(
            [[
            {} {}({})
            {{
                {}
            }}
            ]],
            {
                i(1, 'int'),
                i(2, 'MyFunction'),
                i(3),
                i(4),
            }
        )
    ),

    s(
        'WHILE',
        fmt(
            [[
        while({})
        {{
            {}
        }}
        ]],
            {
                i(1, 'true'),
                i(2),
            }
        )
    ),

    s(
        'PRINT',
        fmt(
            [[
        printf("{}", {});
        ]],
            {
                i(1),
                i(2),
            }
        )
    ),

    s(
        'INCLUDE',
        fmt(
            [[
            {}
        ]],
            {
                c(1, {
                    sn(nil, {
                        t('#include "'),
                        i(1),
                        t('"'),
                    }),
                    sn(nil, {
                        t('#include <'),
                        i(1),
                        t('>'),
                    }),
                    t('#include <assert.h>'),
                    t('#include <complex.h>'),
                    t('#include <ctype.h>'),
                    t('#include <errno.h>'),
                    t('#include <fenv.h>'),
                    t('#include <float.h>'),
                    t('#include <inttypes.h>'),
                    t('#include <iso646.h>'),
                    t('#include <limits.h>'),
                    t('#include <locale.h>'),
                    t('#include <math.h>'),
                    t('#include <setjmp.h>'),
                    t('#include <signal.h>'),
                    t('#include <stdalign.h>'),
                    t('#include <stdarg.h>'),
                    t('#include <stdatomic.h>'),
                    t('#include <stdbit.h>'),
                    t('#include <stdbool.h>'),
                    t('#include <stdckdint.h>'),
                    t('#include <stddef.h>'),
                    t('#include <stdint.h>'),
                    t('#include <stdio.h>'),
                    t('#include <stdlib.h>'),
                    t('#include <stdnoreturn.h>'),
                    t('#include <string.h>'),
                    t('#include <tgmath.h>'),
                    t('#include <threads.h>'),
                    t('#include <time.h>'),
                    t('#include <uchar.h>'),
                    t('#include <wchar.h>'),
                    t('#include <wctype.h>'),
                }),
            }
        )
    ),
}

return snippets, autosnippets
