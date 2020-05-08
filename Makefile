CC := g++
FILENAME := yoga
FILEENDING :=
SRC_DIR := yoga
SRC_FILES := $(wildcard $(SRC_DIR)/*.cpp)
OBJ_DIR32 := x86
OBJ_DIR64 := x64
OBJ_FILES32 := $(patsubst $(SRC_DIR)/%.cpp,$(OBJ_DIR32)/%.o,$(SRC_FILES))
OBJ_FILES64 := $(patsubst $(SRC_DIR)/%.cpp,$(OBJ_DIR64)/%.o,$(SRC_FILES))
LDFLAGS := -shared
CPPFLAGS := -fPIC -std=c++11

ifeq ($(OS),Windows_NT)
	FILEENDING := dll
else
	UNAME_S := $(shell uname -s)

	ifeq ($(UNAME_S),Linux)
		FILEENDING := so
	endif

	ifeq ($(UNAME_S),Darwin)
		FILEENDING := dylib
	endif
endif

all: $(OBJ_DIR32)/$(FILENAME).$(FILEENDING) $(OBJ_DIR64)/$(FILENAME).$(FILEENDING)

$(OBJ_DIR32)/$(FILENAME).$(FILEENDING): $(OBJ_FILES32)
	$(CC) -m32 $(LDFLAGS) -o $@ $^

$(OBJ_DIR32)/%.o: $(SRC_DIR)/%.cpp
	$(CC) -m32 $(CPPFLAGS) -c -o $@ $<

$(OBJ_DIR64)/$(FILENAME).$(FILEENDING): $(OBJ_FILES64)
	$(CC) -m64 $(LDFLAGS) -o $@ $^

$(OBJ_DIR64)/%.o: $(SRC_DIR)/%.cpp
	$(CC) -m64 $(CPPFLAGS) -c -o $@ $<
