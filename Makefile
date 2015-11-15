
BUILDDIR := bin/object/			# Directory to store object files
CC := nvcc				# Compiler
ARCH := 52				# Device target architecture

# @@@@@@@@@@@@@@@@@@@@@@@@ Compiler flags @@@@@@@@@@@@@@@@@@@@@@@@ 
FLAGS := -lineinfo -O3 --use_fast_math -std=c++11 -gencode arch=compute_${ARCH},code=compute_${ARCH} -gencode arch=compute_${ARCH},code=sm_${ARCH} --relocatable-device-code=true
CCFLAGS := -c

# @@@@@@@@@@@@@@@@@@@@@@@@ Library paths @@@@@@@@@@@@@@@@@@@@@@@@ 
LIBPATH := -L/usr/local/cuda-7.5/targets/x86_64-linux/lib -L/usr/local/lib

# @@@@@@@@@@@@@@@@@@@@@@@@ Libraries @@@@@@@@@@@@@@@@@@@@@@@@ 
LIBS := -lnvToolsExt -lopencv_objdetect -lopencv_imgcodecs -lopencv_videoio -lopencv_calib3d -lopencv_features2d -lopencv_video -lopencv_ml -lopencv_highgui -lopencv_imgproc -lopencv_core -lopencv_flann

# @@@@@@@@@@@@@@@@@@@@@@@@ Inlcude paths @@@@@@@@@@@@@@@@@@@@@@@@ 
INCL := -I/usr/local/include/opencv -I/usr/local/include/cuda-7.5/targets/x86_64-linux/include

# @@@@@@@@@@@@@@@@@@@@@@@@ Object files @@@@@@@@@@@@@@@@@@@@@@@@ 
OBJS := ${BUILDDIR}Utils.o ${BUILDDIR}IniFileIO.o ${BUILDDIR}cParameters.o ${BUILDDIR}AccumulativeRefinement.o ${BUILDDIR}Maths.o ${BUILDDIR}Refinement.o ${BUILDDIR}RoiCluster.o ${BUILDDIR}visionSys.o


all: ${OBJS}
	@echo "Building target..."
	${CC} ${FLAGS} ${LIBPATH} --cudart shared -link -o bin/visionSystem ${OBJS} ${LIBS}

${BUILDDIR}visionSys.o: src/visionSys.cu
	${CC} ${FLAGS} ${CCFLAGS} ${LIBPATH} ${INCL} $? -o $@ ${LIBS}

${BUILDDIR}Utils.o: src/init/fileInOut/Utils.cu
	${CC} ${FLAGS} ${CCFLAGS} ${LIBPATH} ${INCL} $? -o $@ ${LIBS}

${BUILDDIR}IniFileIO.o: src/init/fileInOut/IniFileIO.cu
	${CC} ${FLAGS} ${CCFLAGS} ${LIBPATH} ${INCL} $? -o $@ ${LIBS}

${BUILDDIR}cParameters.o: src/init/cParameters.cu
	${CC} ${FLAGS} ${CCFLAGS} ${LIBPATH} ${INCL} $? -o $@ ${LIBS}

${BUILDDIR}AccumulativeRefinement.o: src/common/AccumulativeRefinement.cu
	${CC} ${FLAGS} ${CCFLAGS} ${LIBPATH} ${INCL} $? -o $@ ${LIBS}

${BUILDDIR}Maths.o: src/common/Maths.cu
	${CC} ${FLAGS} ${CCFLAGS} ${LIBPATH} ${INCL} $? -o $@ ${LIBS}

${BUILDDIR}Refinement.o: src/common/Refinement.cu
	${CC} ${FLAGS} ${CCFLAGS} ${LIBPATH} ${INCL} $? -o $@ ${LIBS}

${BUILDDIR}RoiCluster.o: src/common/RoiCluster.cu
	${CC} ${FLAGS} ${CCFLAGS} ${LIBPATH} ${INCL} $? -o $@ ${LIBS}

clean:
	@echo "Cleaning up..."
	rm bin/object/*
	rm bin/*
