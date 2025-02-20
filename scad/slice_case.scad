$fn = $preview ? 64 : 128;
zFite = $preview ? 0.1 : 0;

slice_height = 100;
slice_width = 70;
slice_thickness = 1.6;
slice_corner_radius = 5;
slice_hole_diameter = 5;
slice_hole_edge_offset = 5;

difference()
{
    union()
    {
        difference()
        {

            // main body
            cube([ slice_width, slice_height, slice_thickness ], center = true);

            // cut from corners
            for (i = [0:3])
            {
                translate(
                    [ slice_width / 2 * (i % 2 == 0 ? 1 : -1), slice_height / 2 * (floor(i / 2) == 0 ? 1 : -1), 0 ])
                    cube([ slice_corner_radius * 2, slice_corner_radius * 2, slice_thickness * 1.1 ], center = true);
            }
        }

        // corners
        for (i = [0:3])
        {
            translate([
                (slice_width / 2 - slice_corner_radius) * (i % 2 == 0 ? 1 : -1),
                (slice_height / 2 - slice_corner_radius) * (floor(i / 2) == 0 ? 1 : -1), 0
            ]) cylinder(h = slice_thickness, r = slice_corner_radius, center = true);
        }
    }
    // holes
    for (i = [0:3])
    {
        translate([
            (slice_width / 2 - slice_hole_edge_offset) * (i % 2 == 0 ? 1 : -1),
            (slice_height / 2 - slice_hole_edge_offset) * (floor(i / 2) == 0 ? 1 : -1), 0
        ]) cylinder(h = slice_thickness + zFite, r = slice_hole_diameter / 2, center = true);
    }
}