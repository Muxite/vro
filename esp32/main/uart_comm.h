#ifndef UART_COMM_H
#define UART_COMM_H

void uart_comm_init(void);
void uart_send(const char* data);
int uart_receive(char* buffer, int max_len);

#endif
