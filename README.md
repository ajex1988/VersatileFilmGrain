# VFGS - Versatile film grain synthesis

Software model of hardware-friendly film grain synthesis, supporting FGC SEI message.

This software implements a film grain synthesis method that supports both frequency-filtering and auto-regressive modes of the FGC SEI message, while reducing hardware implementation costs compared to SMPTE RDD-5 by doing a sample-based local adaptation, rather than based on a local 8x8 average (which requires line buffers).

The intent is to provide a "one for all" solution, using a single hardware module while supporting different grain models. 

Details of design considerations regarding film grain synthesis can be found in [JVET-AC2020](https://jvet-experts.org/doc_end_user/current_document.php?id=12577) (committee draft of ISO 23007-2 technical report), section 8.

This software is designed as a model for hardware designers; it uses the C language, and is organized in separate layers:
* the hardware layer (in vfgs_hw.c), which runs a the process for the full picture, based on grain patterns memory, local adaptation LUTs, and a few other parameters. This is the piece that is potentially implemented in hardware.
* the firmware layer (in vfgs_fw.c), that converts input model parameters (e.g. FGC SEI) to hardware configuration. This part can be easily modified to adapt to other grain metadata formats, to generate grain patterns in a different way, etc.
* the outer layer, made of the main program and YUV I/O routines.

## Usage

This programs takes an input YUV video and a configuration file, and generates an output YUV video.

The configuration file reflects the contents of an FGC SEI message, and follows the same syntax as in the [VTM](https://vcgit.hhi.fraunhofer.de/jvet/VVCSoftware_VTM). Test configuration files can be found in the cfg/ subfolder. A default configuration is used if none is provided. 

An SEI text dump as output by the VTM or HM can also be ingested instead of a configuration file, an example of which is also found in the cfg/ subfolder. Only the first FGC SEI found in the dump is retained.

When the `--gain` option is used, new valid grain parameters are computed internally before further processing.

Full help is provided when typing `vfgs --help`, with default option values indicated in angle brackets [ ]:

```bash
Usage: vfgs [options] <input.yuv> <output.yuv>

   -w,--width    <value>     Picture width [1920]
   -h,--height   <value>     Picture height [1080]
   -b,--bitdepth <value>     Input bit depth [10]
      --outdepth <value>     Output bit depth (<= input depth) [same as input]
   -f,--format   <value>     Chroma format (420/422/444) [420]
   -n,--frames   <value>     Number of frames to process (0=all) [0]
   -s,--seek     <value>     Picture start index within input file [0]
   -c,--cfg      <filename>  Read film grain configuration file
   -g,--gain     <value>     Apply a global scale (in percent) to grain strength
   --help                    Display this page
````

## Compilation

Compilation is performed either using `cmake` or typing `gcc src/*.c -o vfgs.exe -mavx2` (adapt -mXXX to your machine)

## Contributing

Please use fork and merge requests. Examples of welcome contributions:
- SIMD and GPU acceleration (HW layer)
- HDL code / HW design (HW layer)
- Further improved FGC SEI message support (FW layer)

## License

A BSD 3-clause-clear license is applicable. See the [LICENSE](LICENSE) file.

