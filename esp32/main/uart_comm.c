#include <string.h>
#include "driver/uart.h"
#include "esp_log.h"

static const char *TAG = "UART_COMM";

#define UART_NUM UART_NUM_0
#define BUF_SIZE 1024

void uart_comm_init(void)
{
    uart_config_t uart_config = {
        .baud_rate = 115200,
        .data_bits = UART_DATA_8_BITS,
        .parity = UART_PARITY_DISABLE,
        .stop_bits = UART_STOP_BITS_1,
        .flow_ctrl = UART_HW_FLOWCTRL_DISABLE,
        .source_clk = UART_SCLK_DEFAULT,
    };
    
    ESP_ERROR_CHECK(uart_driver_install(UART_NUM, BUF_SIZE * 2, 0, 0, NULL, 0));
    ESP_ERROR_CHECK(uart_param_config(UART_NUM, &uart_config));
    ESP_ERROR_CHECK(uart_set_pin(UART_NUM, UART_PIN_NO_CHANGE, UART_PIN_NO_CHANGE, 
                                 UART_PIN_NO_CHANGE, UART_PIN_NO_CHANGE));
    
    ESP_LOGI(TAG, "UART initialized");
}

void uart_send(const char* data)
{
    int len = strlen(data);
    uart_write_bytes(UART_NUM, data, len);
}

int uart_receive(char* buffer, int max_len)
{
    int len = uart_read_bytes(UART_NUM, (uint8_t*)buffer, max_len - 1, 100 / portTICK_PERIOD_MS);
    if (len > 0) {
        buffer[len] = '\0';
    }
    return len;
}
