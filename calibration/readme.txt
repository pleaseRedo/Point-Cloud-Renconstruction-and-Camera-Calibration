This folder includes both synthetic and real datasets. The synthetic sequences are provided for testing/debugging, so feel free to use one or more of these when debugging your system. While we would like to see output from real data in your report, there is no requirement to use all of the provided sequences.

Both synthetic and real datasets use the Gray codes provided in gray_code_pattern.zip - the zip file includes the image sequence. All of the provided image sequences are in the same order. It also includes Python code to generate the image sequence (you can edit the resolution to match the projector you use) and a .json file that describes the image sequence in terms of on/off image pairs and the offset to apply to all pixels that are on from the origin.



Synthetic Data:
---------------

The calibration sequence may be found in synthetic_calibration.zip. The rest of the files are listed below. Note that these sequences are all 'perfect' - they are anti-aliased, but contain none of the imperfections found in real data. The synthetic calibration has been provided, in several different forms as JSON files, which are human readable. synthetic.calibration contains the camera parameters broken down into separate parts - position, rotation etc. synthetic.matrices contains just the raw matrices, and is the easier file to use.

To help with debugging synthetic.ply has been provided - it contains a 3D model of the camera and projector so you can see their relationship. Be aware that if you do your own calibration the global rotation, offset and scale may not match. Additionally, synthetic_cube.avi is a fly around of the output when we run our reference implementation on the synthetic_cube.zip input, so you have an idea of what to expect. Note that instead of calculating the synthetic calibration perfectly we used the same calibration tool we would use for real input. This means that due to the inaccuracy of a human clicking on corners you won't get perfect output.


synthetic_cube.zip - Flat shaded and entirely visible. The easiest test case.

synthetic_sphere.zip - Part of the sphere is in the shadow of the projector, and can't be reconstructed. Has a smoothly varying texture.

synthetic_monkey.zip - Object that includes concavities. Has a texture with abrupt changes.

synthetic_red.zip - Clutter of many nearby objects on a plane, with assorted complex materials that happen to be red.

synthetic_tablet.zip - Realistic geometry with subtle details; note that the buttons on the left side of the graphics tablet have a slight indentation to them.

synthetic_notebook.zip - Another realistic-looking object; includes fine hair, which can create artefacts in the reconstruction.



Real Data:
----------

The projector was a 3M MP160 Pocket Projector, and the camera was a Canon 550D. The calibration grid was 3.3cm along the side of each square. The calibration is in real_calibration.zip, the remaining files are described below. The projector has some chromatic aberration, so it would be wise to use one colour channel rather than combining all three. Additionally, the high frequency Gray code patterns are unusable as the projector only supports 800x600, when we drove it at 1024x768, so you should ignore them.


real_head.zip - A simple bust.

real_tea.zip - Tea, earl grey, still in its box. Has an awkward pattern, but still an easy one to reconstruct. Should also be able to reconstruct the chair it is sitting on.

real_crayon_dalek.zip - A Dalek exterminating a set of crayons. The Dalek has been 3D printed at quite a low quality, so will not be particularly great when reconstructed.

real_ball_tea.zip - A mug and some balls. The balls may have some artefacts due to them being slightly transparent.

real_shiny.zip - A gold Buddha and a Chinese dragon. There is some translucency on the dragon, so it may prove challenging to reconstruct in some regions, and the shininess may also cause issues.

real_hat.zip - An awesome hat. Quite hard, due to low albedo and it being hairy.

