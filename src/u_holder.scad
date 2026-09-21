/*
  Reusable geometry primitives for pegboard accessories built around
  open-front U-shaped tool supports.

  Coordinate convention is deliberately parameterized:
    - X is shelf depth
    - Y is shelf width
    - Z is vertical
    - face_x is the pegboard/backplate front face
    - top_z is the shelf top surface

  These helpers are not driver-specific and can be reused by future
  plier, cutter, probe, cable, or tool holders.
*/


// Open-front U slot: circular seat plus a straight access channel toward
// shelf_front_x.
module u_holder_slot_cut(
    slot_d,
    axis_x,
    shelf_front_x,
    thickness,
    top_z,
    eps=0.15,
    fn=48
) {
    translate([axis_x,0,top_z-thickness-eps])
        cylinder(d=slot_d, h=thickness+2*eps, $fn=fn);

    translate([
        shelf_front_x-eps,
        -slot_d/2,
        top_z-thickness-eps
    ])
        cube([
            axis_x - shelf_front_x + slot_d/2 + 2*eps,
            slot_d,
            thickness + 2*eps
        ]);
}


// Top-edge contact chamfer for an open U slot.
// The straight-wall support diameter remains unchanged below the chamfer.
// With chamfer=1.0 this is approximately a 1 x 1 mm 45-degree edge break.
module u_holder_top_chamfer_cut(
    slot_d,
    axis_x,
    shelf_front_x,
    chamfer,
    top_z,
    eps=0.05,
    fn=64
) {
    if (chamfer > 0)
        hull() {
            // Nominal U profile at the bottom of the chamfer.
            union() {
                translate([axis_x,0,top_z-chamfer-eps])
                    cylinder(d=slot_d, h=eps, $fn=fn);

                translate([
                    shelf_front_x-eps,
                    -slot_d/2,
                    top_z-chamfer-eps
                ])
                    cube([
                        axis_x - shelf_front_x + slot_d/2 + 2*eps,
                        slot_d,
                        eps
                    ]);
            }

            // Expanded U profile at the top surface.
            union() {
                translate([axis_x,0,top_z+eps])
                    cylinder(
                        d=slot_d + 2*chamfer,
                        h=eps,
                        $fn=fn
                    );

                translate([
                    shelf_front_x-eps,
                    -(slot_d/2 + chamfer),
                    top_z+eps
                ])
                    cube([
                        axis_x - shelf_front_x + slot_d/2 + chamfer + 2*eps,
                        slot_d + 2*chamfer,
                        eps
                    ]);
            }
        }
}


// Concave quarter-round root fillet where a cantilevered shelf meets its
// vertical backplate. Adds material and reduces the inside-corner stress riser.
module u_holder_root_fillet(
    width,
    radius,
    face_x,
    top_z,
    eps=0.15,
    fn=48
) {
    if (radius > 0)
        difference() {
            translate([
                face_x-radius,
                -width/2,
                top_z
            ])
                cube([
                    radius,
                    width,
                    radius
                ]);

            translate([
                face_x-radius,
                0,
                top_z+radius
            ])
                rotate([90,0,0])
                    cylinder(
                        r=radius,
                        h=width + 2*eps,
                        center=true,
                        $fn=fn
                    );
        }
}


// Single centered-U shelf with semicircular front ends on both arms.
// The default end-cap radius is half the arm width, producing a true
// semicircular nose without changing the support-slot diameter.
module u_holder_rounded_single_shelf(
    width,
    depth,
    slot_d,
    thickness,
    face_x,
    top_z,
    front_cap_r=undef,
    fn=48
) {
    arm_w = (width - slot_d) / 2;
    cap_r = is_undef(front_cap_r) ? arm_w / 2 : min(front_cap_r, arm_w / 2);
    front_x = face_x - depth;

    union() {
        translate([
            front_x + cap_r,
            -width/2,
            top_z-thickness
        ])
            cube([
                depth - cap_r,
                width,
                thickness
            ]);

        for (sy = [-1, 1])
            translate([
                front_x + cap_r,
                sy * (slot_d/2 + arm_w/2),
                top_z-thickness
            ])
                cylinder(
                    r=cap_r,
                    h=thickness,
                    $fn=fn
                );
    }
}
