function x = lpdec(c, d, h, g)
% LPDEC   Laplacian Pyramid Reconstruction
%
%	x = lpdec(c, d, h, g)
%
% Input:
%   c:      coarse image at half size
%   d:      detail image at full size
%   h, g:   two lowpass filters for the Laplacian pyramid
%
% Output:
%   x:      reconstructed image
%
% See also:	LPDEC, PDFBREC

% First, filter and downsample the detail image
xhi = sefilter2(d, h, h, 'per');
xhi = xhi(1:2:end, 1:2:end);

% Subtract from the coarse image, and then upsample and filter
xlo = c - xhi;    
xlo = dup(xlo, [2, 2]);

% Even size filter needs to be adjusted to obtain 
% perfect reconstruction with zero shift
adjust = mod(length(g) + 1, 2); 
            
xlo = sefilter2(xlo, g, g, 'per', adjust * [1, 1]);

% Final combination
x = xlo + d;