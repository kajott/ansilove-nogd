#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "gd.h"

gdImagePtr gdImageCreate(int sx, int sy) {
    (void)sx, (void)sy;
    return NULL;
}

gdImagePtr gdImageCreateTrueColor(int sx, int sy) {
    (void)sx, (void)sy;
    return NULL;
}

void gdImageDestroy(gdImagePtr im) {
    (void)im;
}

int gdImageColorAllocate(gdImagePtr im, int r, int g, int b) {
    (void)im, (void)r, (void)g, (void)b;
    return 0;
}

void gdImageColorTransparent(gdImagePtr im, int color) {
    (void)im, (void)color;
}

void gdImageFill(gdImagePtr im, int x, int y, int nc) {
    (void)im, (void)x, (void)y, (void)nc;
}

void gdImageFilledRectangle(gdImagePtr im, int x1, int y1, int x2, int y2, int color) {
    (void)im, (void)x1, (void)y1, (void)x2, (void)y2, (void)color;
}

void gdImageSetPixel(gdImagePtr im, int x, int y, int color) {
    (void)im, (void)x, (void)y, (void)color;
}

void gdImageCopyResized(gdImagePtr dst, gdImagePtr src, int dstX, int dstY, int srcX, int srcY, int dstW, int dstH, int srcW, int srcH) {
    (void)dst, (void)src, (void)dstX, (void)dstY, (void)srcX, (void)srcY, (void)dstW, (void)dstH, (void)srcW, (void)srcH;
}

void gdImageCopyResampled(gdImagePtr dst, gdImagePtr src, int dstX, int dstY, int srcX, int srcY, int dstW, int dstH, int srcW, int srcH) {
    (void)dst, (void)src, (void)dstX, (void)dstY, (void)srcX, (void)srcY, (void)dstW, (void)dstH, (void)srcW, (void)srcH;
}

void* gdImagePngPtr(gdImagePtr im, int *size) {
    (void)im, (void)size;
    return NULL;
}

void gdFree(void* ptr) {
    free(ptr);
}
