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
}

local autosnippets = {

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
}

return snippets, autosnippets
