function overlay(image, norm)

norm = uint8(norm);

for i = 1:size(norm,1)
    for j = 1:size(norm,2)
        if norm(i,j) == 1
            norm(i,j) = 255;
        end
        
        ind = sub2ind(size(image),i,j);
        image(ind) = norm(i,j);
    end
end
imshow(image)


