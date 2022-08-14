#ifndef GD_H_
#define GD_H_

typedef struct _gdimage {
    int sx, sy;
    int data[1];
} gdImage;
typedef gdImage* gdImagePtr;

#define gdImageTrueColor(im) (1)  // we only emulate truecolor images

extern gdImagePtr gdImageCreate(int sx, int sy);
extern gdImagePtr gdImageCreateTrueColor(int sx, int sy);
extern void gdImageDestroy(gdImagePtr im);
extern int gdImageColorAllocate(gdImagePtr im, int r, int g, int b);
extern void gdImageColorTransparent(gdImagePtr im, int color);
extern void gdImageFill(gdImagePtr im, int x, int y, int nc);
extern void gdImageFilledRectangle(gdImagePtr im, int x1, int y1, int x2, int y2, int color);
extern void gdImageSetPixel(gdImagePtr im, int x, int y, int color);
extern void gdImageCopyResized(gdImagePtr dst, gdImagePtr src, int dstX, int dstY, int srcX, int srcY, int dstW, int dstH, int srcW, int srcH);
extern void gdImageCopyResampled(gdImagePtr dst, gdImagePtr src, int dstX, int dstY, int srcX, int srcY, int dstW, int dstH, int srcW, int srcH);
extern void* gdImagePngPtr(gdImagePtr im, int *size);
extern void gdFree(void* ptr);

#endif // GD_H_
