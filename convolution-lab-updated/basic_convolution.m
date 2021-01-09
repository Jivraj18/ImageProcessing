function [iOut] = basic_convolution(iSource, k)

image = iSource;

imgSize = size(image);
numberOfRows = size(image, 2);
numberOfColumns = size(image, 1);

iOut = zeros(imgSize(1), imgSize(1,1));

kernelRows = size(k, 2);
kernelColumns = size(k,1);
midKernelRows = round(kernelColumns(1) / 2) - 1;
midKernelColumns = round(kernelRows(1,1) / 2) - 1;

for imgRow = 1: numberOfColumns
    for pixel = 1: numberOfRows
        accumulator = 0;
        if imgRow - midKernelRows >= 1 && imgRow + midKernelRows <= imgSize(1) && pixel - midKernelColumns >= 1 && pixel + midKernelColumns <= imgSize(1)
            pixelRow = imgRow - midKernelRows;
            pixelColumn = pixel - midKernelColumns;
            for kernelRow = 1: kernelColumns
                for element = 1: kernelRows
                    rightBorder = numberOfRows - midKernelRows;
                    bottomBorder = numberOfColumns - midKernelColumns;
                    if imgRow < midKernelRows ||pixel < midKernelColumns || imgRow - 1 > rightBorder || pixel - 1 > bottomBorder
                    else
                    pixelValue = iSource(pixelRow, pixelColumn);
                    elementValue = k(kernelRow, element);
                    accumulator = accumulator + (pixelValue * elementValue);
                    pixelColumn = pixelColumn + 1;
                    end
                end
                pixelRow = pixelRow + 1;
                pixelColumn = pixel - midKernelColumns;
            end
        end
        iOut(imgRow, pixel) = accumulator;
    end
end
end
