#include <stdio.h>
#include <string.h>
#include "driver/gpio.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

#define BLINK_GPIO 2
#define BLINK_DELAY_MS 200

char* text = "Hello, World!";

void app_main(void)
{
    gpio_reset_pin(BLINK_GPIO);
    gpio_set_direction(BLINK_GPIO, GPIO_MODE_OUTPUT);

    printf("Blinking LED on GPIO %d\n", BLINK_GPIO);

    while (1) {
        for (int i = 0; i < strlen(text); i++) {
            char c = text[i];
            for (int bit = 7; bit >= 0; bit--) {
                int bit_value = (c >> bit) & 1; // basic mask for bit value
                gpio_set_level(BLINK_GPIO, bit_value);
                vTaskDelay(BLINK_DELAY_MS / portTICK_PERIOD_MS);
            }
            gpio_set_level(BLINK_GPIO, 0);
            vTaskDelay(BLINK_DELAY_MS / portTICK_PERIOD_MS);
        }
        vTaskDelay(10 * BLINK_DELAY_MS / portTICK_PERIOD_MS);
    }
}
