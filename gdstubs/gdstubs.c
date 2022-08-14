#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "gd.h"
#include "lodepng.h"

gdImagePtr gdImageCreateTrueColor(int sx, int sy) {
    gdImagePtr im = (gdImagePtr) calloc((sx * sy) * sizeof(int) + sizeof(gdImage), 1);
    if (im) { im->sx = sx; im->sy = sy; }
    gdImageFill(im, 0, 0, 0xFF000000);
    return im;
}

void gdImageDestroy(gdImagePtr im) {
    free((void*)im);
}

int gdImageColorAllocate(gdImagePtr im, int r, int g, int b) {
    (void)im;
    return r | (g << 8) | (b << 16) | 0xFF000000;
}

void gdImageColorTransparent(gdImagePtr im, int color) {
    (void)im, (void)color;
}

void gdImageFill(gdImagePtr im, int x, int y, int nc) {
    int *p, n;
    (void)x, (void)y;
    if (!im) { return; }
    n = im->sx * im->sy;
    for (int *p = im->data;  n;  --n) {
        *p++ = nc;
    }
}

void gdImageFilledRectangle(gdImagePtr im, int x1, int y1, int x2, int y2, int color) {
    if (!im) { return; }
    for (int y = y1;  y <= y2;  ++y) {
        int *line = &im->data[im->sx * y];
        for (int x = x1;  x <= x2;  ++x) {
            line[x] = color;
        }
    }
}

void gdImageSetPixel(gdImagePtr im, int x, int y, int color) {
    if (im) { im->data[im->sx * y + x] = color; }
}

void gdImageCopyResized(gdImagePtr dst, gdImagePtr src, int dstX, int dstY, int srcX, int srcY, int dstW, int dstH, int srcW, int srcH) {
    (void)dst, (void)src, (void)dstX, (void)dstY, (void)srcX, (void)srcY, (void)dstW, (void)dstH, (void)srcW, (void)srcH;
}

void gdImageCopyResampled(gdImagePtr dst, gdImagePtr src, int dstX, int dstY, int srcX, int srcY, int dstW, int dstH, int srcW, int srcH) {
    (void)dst, (void)src, (void)dstX, (void)dstY, (void)srcX, (void)srcY, (void)dstW, (void)dstH, (void)srcW, (void)srcH;
}

void* gdImagePngPtr(gdImagePtr im, int *size) {
    unsigned char* out = NULL;
    size_t outsize = 0;
    if (size) { *size = 0; }
    if (!im) { return NULL; }
    if (lodepng_encode_memory(&out, &outsize, (const unsigned char*)&im->data[0], im->sx, im->sy, LCT_RGBA, 8)) { return NULL; }
    if (size) { *size = (int)outsize; }
    return out;
}

void gdFree(void* ptr) {
    free(ptr);
}
