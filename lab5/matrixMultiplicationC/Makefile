CC = gcc
CFLAGS = -Wall -O0
LDFLAGS = -lgsl -lgslcblas -lm

SRCS = main.c naive.c better.c blas.c
OBJS = $(SRCS:.c=.o)
TARGET = main

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

%.o: %.c
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f $(OBJS) $(TARGET)