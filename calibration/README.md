# Calibration coupons

Calibration STL files are generated from source rather than committed as binary artifacts.

Examples:

```bash
openscad -o build/eureka_5p5.stl calibration/eureka_5p5.scad
openscad -o build/spampur_6p1.stl calibration/spampur_6p1.scad
openscad -o build/spampur_6p2.stl calibration/spampur_6p2.scad
```

Always print calibration parts at **100% scale**.

Current physical results are tracked in `docs/TEST_LOG.md`.
