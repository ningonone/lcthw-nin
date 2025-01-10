CFLAGS = -g -Wall
CFLAGS += -I./include

SRCS = $(wildcard src/*.c)
OBJS = $(patsubst %.c, %.o, $(SRCS))

TEST_SRC = $(wildcard tests/*_tests.c)
TESTS = $(patsubst tests/%.c, %,$(TEST_SRC))

TARGET = build/liblcthw.so

all: $(TARGET) tests

$(TARGET): build $(OBJS)
	$(CC) -shared -o $@ $(OBJS)

$(OBJS): %.o: %.c
	$(CC) -fPIC -c $< -o $@ $(CFLAGS)

build:
	@mkdir -p build
	@mkdir -p bin

.PHONY: tests
tests: LDLIBS += $(TARGET)
tests: $(TESTS)
	sh runtests.sh

$(TESTS): $(TEST_SRC)
	$(CC) $(CFLAGS) -o bin/$@ $< $(LDLIBS)

clean:
	rm -rf build bin $(OBJS) $(TESTS)
	rm -f tests/tests.log

