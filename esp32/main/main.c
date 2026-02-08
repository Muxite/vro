#include <stdio.h>
#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "uart_comm.h"

void app_main(void)
{
    char rx_buffer[256];
    
    printf("ESP32 UART Communication Initialized\n");
    
    uart_comm_init();
    
    printf("Ready to communicate with Raspberry Pi\n");
    printf("Send data via UART at 115200 baud\n");
    
    while (1) {
        int len = uart_receive(rx_buffer, sizeof(rx_buffer));
        
        if (len > 0) {
            printf("Received from Pi: %s\n", rx_buffer);
            
            char response[128];
            snprintf(response, sizeof(response), "ESP32 received: %s\n", rx_buffer);
            uart_send(response);
        }
        
        vTaskDelay(10 / portTICK_PERIOD_MS);
    }
}
