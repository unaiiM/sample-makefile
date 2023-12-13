TARGET = app
SRCDIR = ./src
INCDIR = ./include
OBJDIR = ./obj
CC = gcc

SRCS  = $(wildcard $(SRCDIR)/*.c)
OBJS = $(patsubst $(SRCDIR)/%.c,$(OBJDIR)/%.o,$(SRCS))
DEPS = $(OBJS:.o=.d)

INCLUDES = -I$(INCDIR)
CFLAGS = -O2 -Wall -MMD -MP $(INCLUDES)
LDFLAGS = -lm

.PHONY: all run clean

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $(OBJS)

$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

run: all
	@./$(TARGET)

clean:
	$(RM) -r $(OBJDIR) $(TARGET)

-include $(DEPS)

$(OBJDIR):
	mkdir -p $(OBJDIR)