CLANG 	?= ../../../llvm-myriscvx100/build/bin/clang
LLC   	?= ../../../llvm-myriscvx100/build/bin/llc
DUMP  	?= ../../../llvm-myriscvx100/build/bin/llvm-dis
MC    	?= ../../../llvm-myriscvx100/build/bin/llvm-mc
OBJDUMP ?= ../../../llvm-myriscvx100/build/bin/llvm-objdump

RISCV32 = ${HOME}/riscv32
RISCV64 = ${HOME}/riscv64

func_arguments.o: func_arguments.c Makefile
	riscv32-unknown-elf-gcc -O0 $< -c -o $@
	riscv32-unknown-elf-objdump -d $@ > $@.dmp

COMMON_OPTIONS =
COMMON_OPTIONS += --debug
COMMON_OPTIONS += -disable-tail-calls

define WHOLE_RULES

# $(1): $(1).myriscvx32.static.S.o $(1).myriscvx32.pic.S.o $(1).riscv32.static.S.o $(1).riscv32.pic.S.o \
# 	$(1).myriscvx32.static.o $(1).myriscvx32.pic.o $(1).riscv32.static.o $(1).riscv32.pic.o \
# 	$(1).myriscvx32.static.S $(1).myriscvx32.pic.S $(1).riscv32.static.S $(1).riscv32.pic.S

$(1).riscv32.static.S.o   : $(1).riscv32.static.S Makefile
	-$(MC)      --arch=riscv32 $(1).riscv32.static.S --filetype=obj --debug -o $(1).riscv32.static.o > $(1).riscv32.static.S.o.log 2>&1
	-$(OBJDUMP) -r -D $(1).riscv32.static.o > $(1).riscv32.static.dmp
$(1).riscv32.pic.S.o      : $(1).riscv32.pic.S Makefile
	-$(MC)      --arch=riscv32 $(1).riscv32.pic.S --filetype=obj --debug -o $(1).riscv32.pic.o > $(1).riscv32.pic.S.o.log 2>&1
	-$(OBJDUMP) -r -D $(1).riscv32.pic.o > $(1).riscv32.pic.dmp
$(1).myriscvx32.static.S.o: $(1).myriscvx32.static.S Makefile
	-$(MC)      --arch=myriscvx32 $(1).myriscvx32.static.S --filetype=obj --debug -o $(1).myriscvx32.static.o > $(1).myriscvx32.static.S.o.log 2>&1
	-$(OBJDUMP) -r -D $(1).myriscvx32.static.o > $(1).myriscvx32.static.dmp
$(1).myriscvx32.pic.S.o   : $(1).myriscvx32.pic.S Makefile
	-$(MC)      --arch=myriscvx32 $(1).myriscvx32.pic.S --filetype=obj --debug -o $(1).myriscvx32.pic.o > $(1).myriscvx32.pic.S.o.log 2>&1
	-$(OBJDUMP) -r -D $(1).myriscvx32.pic.o > $(1).myriscvx32.pic.dmp
$(1).mips32.static.S.o: $(1).mips32.static.S Makefile
	-PATH=$(RISCV32)/bin LD_LIBRARY_PATH=$(RISCV32)/lib riscv32-unknown-elf-gcc -O3 -c $(1).mips32.static.S -o $(1).mips32.static.S.o
	-PATH=$(RISCV32)/bin LD_LIBRARY_PATH=$(RISCV32)/lib riscv32-unknown-elf-objdump -r -D $(1).mips32.static.S.o > $(1).mips32.static.dmp
$(1).mips32.pic.S.o   : $(1).mips32.pic.S Makefile
	-PATH=$(RISCV32)/bin LD_LIBRARY_PATH=$(RISCV32)/lib riscv32-unknown-elf-gcc -O3 -c $(1).mips32.pic.S -o $(1).mips32.pic.S.o
	-PATH=$(RISCV32)/bin LD_LIBRARY_PATH=$(RISCV32)/lib riscv32-unknown-elf-objdump -r -D $(1).mips32.pic.S.o > $(1).mips32.pic.dmp


$(1).riscv32.static.S: $(1).riscv.static.bc Makefile
	-$(LLC) -march=riscv32		$(COMMON_OPTIONS) -relocation-model=static -filetype=asm -o $(1).riscv32.static.S $(1).riscv.static.bc		> $(1).riscv32.static.asm.log 2>&1
$(1).riscv64.static.S: $(1).riscv.static.bc Makefile
	-$(LLC) -march=riscv64		$(COMMON_OPTIONS) -relocation-model=static -filetype=asm -o $(1).riscv64.static.S $(1).riscv.static.bc		> $(1).riscv64.static.asm.log 2>&1
$(1).riscv32.static.o: $(1).riscv.static.bc Makefile
	-$(LLC) -march=riscv32		$(COMMON_OPTIONS) -relocation-model=static -filetype=obj -o $(1).riscv32.static.o $(1).riscv.static.bc		> $(1).riscv32.static.obj.log 2>&1
$(1).riscv64.static.o: $(1).riscv.static.bc Makefile
	-$(LLC) -march=riscv64		$(COMMON_OPTIONS) -relocation-model=static -filetype=obj -o $(1).riscv64.static.o $(1).riscv.static.bc		> $(1).riscv64.static.obj.log 2>&1
$(1).myriscvx32.static.S: $(1).riscv.static.bc Makefile
	-$(LLC) -march=myriscvx32	$(COMMON_OPTIONS) -relocation-model=static -filetype=asm -o $(1).myriscvx32.static.S $(1).riscv.static.bc	> $(1).myriscvx32.static.asm.log 2>&1
$(1).myriscvx64.static.S: $(1).riscv.static.bc Makefile
	-$(LLC) -march=myriscvx64	$(COMMON_OPTIONS) -relocation-model=static -filetype=asm -o $(1).myriscvx64.static.S $(1).riscv.static.bc	> $(1).myriscvx64.static.asm.log 2>&1
$(1).myriscvx32.static.o: $(1).riscv.static.bc Makefile
	-$(LLC) -march=myriscvx32	$(COMMON_OPTIONS) -relocation-model=static -filetype=obj -o $(1).myriscvx32.static.o $(1).riscv.static.bc	> $(1).myriscvx32.static.obj.log 2>&1
$(1).myriscvx64.static.o: $(1).riscv.static.bc Makefile
	-$(LLC) -march=myriscvx64	$(COMMON_OPTIONS) -relocation-model=static -filetype=obj -o $(1).myriscvx64.static.o $(1).riscv.static.bc	> $(1).myriscvx64.static.obj.log 2>&1
$(1).mips32.static.S: $(1).mips.bc Makefile
	-$(LLC) -march=mips			$(COMMON_OPTIONS) -relocation-model=static -filetype=asm -o $(1).mips32.static.S $(1).mips.bc		> $(1).mips32.static.asm.log 2>&1
$(1).mips64.static.S: $(1).mips.bc Makefile
	-$(LLC) -march=mips64		$(COMMON_OPTIONS) -relocation-model=static -filetype=asm -o $(1).mips64.static.S $(1).mips.bc		> $(1).mips64.static.asm.log 2>&1
$(1).mips32.static.o: $(1).mips.bc Makefile
	-$(LLC) -march=mips			$(COMMON_OPTIONS) -relocation-model=static -filetype=obj -o $(1).mips32.static.o $(1).mips.bc		> $(1).mips32.static.obj.log 2>&1
$(1).mips64.static.o: $(1).mips.bc Makefile
	-$(LLC) -march=mips64		$(COMMON_OPTIONS) -relocation-model=static -filetype=obj -o $(1).mips64.static.o $(1).mips.bc		> $(1).mips64.static.obj.log 2>&1
$(1).myriscvx32.static.medany.S: $(1).riscv.pic.bc Makefile
	-$(LLC) -march=myriscvx32	$(COMMON_OPTIONS) -relocation-model=static --code-model=medium -filetype=asm -o $(1).myriscvx32.static.medany.S $(1).riscv.pic.bc		> $(1).myriscvx32.pic.asm.log 2>&1
$(1).myriscvx64.static.medany.S: $(1).riscv.pic.bc Makefile
	-$(LLC) -march=myriscvx64	$(COMMON_OPTIONS) -relocation-model=static --code-model=medium -filetype=asm -o $(1).myriscvx64.static.medany.S $(1).riscv.pic.bc		> $(1).myriscvx64.pic.asm.log 2>&1

$(1).riscv32.pic.S: $(1).riscv.pic.bc Makefile
	-$(LLC) -march=riscv32		$(COMMON_OPTIONS) -relocation-model=pic -filetype=asm -o $(1).riscv32.pic.S $(1).riscv.pic.bc			> $(1).riscv32.pic.asm.log 2>&1
$(1).riscv64.pic.S: $(1).riscv.pic.bc Makefile
	-$(LLC) -march=riscv64		$(COMMON_OPTIONS) -relocation-model=pic -filetype=asm -o $(1).riscv64.pic.S $(1).riscv.pic.bc		> $(1).riscv64.pic.asm.log 2>&1
$(1).riscv32.pic.o: $(1).riscv.pic.bc Makefile
	-$(LLC) -march=riscv32		$(COMMON_OPTIONS) -relocation-model=pic -filetype=obj -o $(1).riscv32.pic.o $(1).riscv.pic.bc			> $(1).riscv32.pic.obj.log 2>&1
$(1).riscv64.pic.o: $(1).riscv.pic.bc Makefile
	-$(LLC) -march=riscv64		$(COMMON_OPTIONS) -relocation-model=pic -filetype=obj -o $(1).riscv64.pic.o $(1).riscv.pic.bc			> $(1).riscv64.pic.obj.log 2>&1
$(1).myriscvx32.pic.S: $(1).riscv.pic.bc Makefile
	-$(LLC) -march=myriscvx32	$(COMMON_OPTIONS) -relocation-model=pic -filetype=asm -o $(1).myriscvx32.pic.S $(1).riscv.pic.bc		> $(1).myriscvx32.pic.asm.log 2>&1
$(1).myriscvx64.pic.S: $(1).riscv.pic.bc Makefile
	-$(LLC) -march=myriscvx64	$(COMMON_OPTIONS) -relocation-model=pic -filetype=asm -o $(1).myriscvx64.pic.S $(1).riscv.pic.bc		> $(1).myriscvx64.pic.asm.log 2>&1

$(1).myriscvx32.pic.o: $(1).riscv.pic.bc Makefile
	-$(LLC) -march=myriscvx32	$(COMMON_OPTIONS) -relocation-model=pic -filetype=obj -o $(1).myriscvx32.pic.o $(1).riscv.pic.bc		> $(1).myriscvx32.pic.obj.log 2>&1
$(1).myriscvx64.pic.o: $(1).riscv.pic.bc Makefile
	-$(LLC) -march=myriscvx64	$(COMMON_OPTIONS) -relocation-model=pic -filetype=obj -o $(1).myriscvx64.pic.o $(1).riscv.pic.bc		> $(1).myriscvx64.pic.obj.log 2>&1
$(1).myriscvx32.pic.medany.S: $(1).riscv.pic.bc Makefile
	-$(LLC) -march=myriscvx32	$(COMMON_OPTIONS) -relocation-model=pic --code-model=medium -filetype=asm -o $(1).myriscvx32.pic.medany.S $(1).riscv.pic.bc		> $(1).myriscvx32.pic.asm.log 2>&1
$(1).myriscvx64.pic.medany.S: $(1).riscv.pic.bc Makefile
	-$(LLC) -march=myriscvx64	$(COMMON_OPTIONS) -relocation-model=pic --code-model=medium -filetype=asm -o $(1).myriscvx64.pic.medany.S $(1).riscv.pic.bc		> $(1).myriscvx64.pic.asm.log 2>&1
$(1).mips32.pic.S: $(1).mips.bc Makefile
	-$(LLC) -march=mips			$(COMMON_OPTIONS) -relocation-model=pic -filetype=asm -o $(1).mips32.pic.S $(1).mips.bc				> $(1).mips32.pic.asm.log 2>&1
$(1).mips64.pic.S: $(1).mips.bc Makefile
	-$(LLC) -march=mips64		$(COMMON_OPTIONS) -relocation-model=pic -filetype=asm -o $(1).mips64.pic.S $(1).mips.bc				> $(1).mips64.pic.asm.log 2>&1
$(1).mips32.pic.o: $(1).mips.bc Makefile
	-$(LLC) -march=mips			$(COMMON_OPTIONS) -relocation-model=pic -filetype=obj -o $(1).mips32.pic.o $(1).mips.bc				> $(1).mips32.pic.obj.log 2>&1
$(1).mips64.pic.o: $(1).mips.bc Makefile
	-$(LLC) -march=mips64		$(COMMON_OPTIONS) -relocation-model=pic -filetype=obj -o $(1).mips64.pic.o $(1).mips.bc				> $(1).mips64.pic.obj.log 2>&1

$(1).riscv.pic.bc: $(1).c Makefile
	$(CLANG) $(CLANG_OPTIONS) -fpic $(1).c -c -target riscv64-unknown-elf -emit-llvm -o $(1).riscv.pic.bc
	$(DUMP) $(1).riscv.pic.bc -o $(1).riscv.pic.bc.ll

$(1).riscv.static.bc: $(1).c Makefile
	$(CLANG) $(CLANG_OPTIONS) $(1).c -c  -target riscv64-unknown-elf -emit-llvm -o $(1).riscv.static.bc
	$(DUMP) $(1).riscv.static.bc -o $(1).riscv.static.bc.ll

endef  # WHOLE_RULES

# # %.riscv32.gcc: %.cpp Makefile
# # 	riscv32-unknown-elf-gcc -O3 -fpic -c $< -o $@
# # 	riscv32-unknown-elf-objdump -D $@ > $@.dmp
#
# %.riscv32.gcc: %.riscv32.S Makefile
# 	PATH=$(RISCV32)/bin LD_LIBRARY_PATH=$(RISCV32)/lib riscv32-unknown-elf-gcc -O3 -fpic -c $< -o $@
# 	PATH=$(RISCV32)/bin LD_LIBRARY_PATH=$(RISCV32)/lib riscv32-unknown-elf-objdump -D $@ > $@.dmp
# %.riscv64.gcc: %.riscv64.S Makefile
# 	PATH=$(RISCV64)/bin LD_LIBRARY_PATH=$(RISCV64)/lib riscv64-unknown-elf-gcc -O3 -fpic -c $< -o $@
# 	PATH=$(RISCV64)/bin LD_LIBRARY_PATH=$(RISCV64)/lib riscv64-unknown-elf-objdump -D $@ > $@.dmp
# %.myriscvx32.gcc: %.myriscvx32.S Makefile
# 	PATH=$(RISCV32)/bin LD_LIBRARY_PATH=$(RISCV32)/lib riscv32-unknown-elf-gcc -O3 -fpic -c $< -o $@
# 	PATH=$(RISCV32)/bin LD_LIBRARY_PATH=$(RISCV32)/lib riscv32-unknown-elf-objdump -D $@ > $@.dmp
# %.myriscvx64.gcc: %.myriscvx64.S Makefile
# 	PATH=$(RISCV64)/bin LD_LIBRARY_PATH=$(RISCV64)/lib riscv64-unknown-elf-gcc -O3 -fpic -c $< -o $@
# 	PATH=$(RISCV64)/bin LD_LIBRARY_PATH=$(RISCV64)/lib riscv64-unknown-elf-objdump -D $@ > $@.dmp
#
# %.riscv32.S: %.bc Makefile
# 	$(LLC) -march=riscv32  $(COMMON_OPTIONS) $< -o $@ 2>&1 | tee $@.riscv32.log
# %.riscv64.S: %.bc Makefile
# 	$(LLC) -march=riscv64 $(COMMON_OPTIONS) $< -o $@ 2>&1 | tee $@.riscv64.log
# %.myriscvx32.S: %.bc Makefile
# 	$(LLC) -march=myriscvx32 $(COMMON_OPTIONS) $< -o $@ 2>&1 | tee $@.myriscvx32.log
# %.myriscvx64.S: %.bc Makefile
# 	$(LLC) -march=myriscvx64 $(COMMON_OPTIONS) $< -o $@ 2>&1 | tee $@.myriscvx64.log
# %.mips32.S: %.mips.bc Makefile
# 	$(LLC) -march=mips32 $(COMMON_OPTIONS) $< -o $@ 2>&1 | tee $@.mips32.log
# %.mips64.S: %.mips.bc Makefile
# 	$(LLC) -march=mips64 $(COMMON_OPTIONS) $< -o $@ 2>&1 | tee $@.mips64.log
# %.bc: %.cpp Makefile
# 	$(CLANG) $(CLANG_OPTIONS) $< -c -target riscv64-unknown-elf -emit-llvm -o $@
# 	$(DUMP) $@ -o $@.ll
# %.bc: %.c Makefile
# 	$(CLANG) $(CLANG_OPTIONS) $< -c -target riscv64-unknown-elf -emit-llvm -o $@
# 	$(DUMP) $@ -o $@.ll
#
# %.mips.bc: %.cpp Makefile
# 	$(CLANG) $(CLANG_OPTIONS) $< -c -target mips64-unknown-elf -emit-llvm -o $@
# 	$(DUMP) $@ -o $@.ll
# %.mips.bc: %.c Makefile
# 	$(CLANG) $(CLANG_OPTIONS) $< -c -target mips64-unknown-elf -emit-llvm -o $@
# 	$(DUMP) $@ -o $@.ll

clean:
	$(RM) *.gcc *.bc *.riscv*.S *.myriscvx*.S *.bc.ll *.log *.dump *.dmp *.o *.riscv *.gcc
