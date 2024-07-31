# Mandelbrot Set Viewer Written in Pascal

_Version 1.0.0+20240731  ([Version Release Notes](#ReleaseNotes))_ 

This is an open source interactive graphic viewer for the **[Mandelbrot Set](https://en.wikipedia.org/wiki/Mandelbrot_set)**.

The viewer allows zooming in and out of the Mandelbrot Set, including re-centering on different areas of the set.

The view also allows selection of alternate color gradients for the Mandelbrot Set.


## About the Software

The software is a self-contained executable program, written in **[Free Pascal](https://www.freepascal.org/)**, that runs on Microsoft Windows or Ubuntu Linux (and presumably other Linux distributions).
(No separate run-time environment is required to run the program.)
The **[Lazarus Integrated Development Environment](https://www.lazarus-ide.org/)** was used to develop the program.
(Both Free Pascal and the Lazarus IDE are free open-source software products.) 

## Downloading and Running the Program

### Microsoft Windows

You can run the Mandelbrot Set viewer program on Microsoft Windows as follows:

- Download the **Mandelbrot.exe** binary executable file from the **bin** sub-folder from this GitHub.com page.

- To uninstall the program, simply delete the **Mandelbrot.exe** file.

### Ubuntu Linux

You can run the Mandelbrot Set viewer program on Ubuntu Linux (and presumably other Linux distributions) as follows:

- Download the **Mandelbrot** binary executable file (with no file extension) from the **bin** sub-folder from this GitHub.com page.

- Ensure the **Mandelbrot** file has the executable permission.  From a Files window, right-click the file, select Properties, and use the Permissions tab to enable the Execute permission.  To do this in a Terminal window, use the following command:
  
    chmod +x Mandelbrot

- To uninstall the program, simply delete the **Mandelbrot** binary executable file.

### Running the Program

Double-click the downloaded copy of **Mandelbrot.exe** (on Windows) or **Mandelbrot** (on Linux) to start the viewer.

When the program starts it displays the **Mandelbrot Set** viewer form.

Here is an image of the viewer form.

![Mandelbrot Viewer](img/Mandelbrot.png?raw=true "Mandelbrot Viewer")

The viewer form contains these elements:

- **Reset** button: Click this to re-initialize the viewer to show the full Mandelbrot Set after zooming in or and around the viewing area.
- **Colors** button: Click this to display a set of various color gradients.  Click on any of the displayed color gradients to select it and the trigger a redraw of the Mandelbrot Set.
- **Redraw** button: Click this to redraw the Mandelbrot Set after changing the size of the viewer form.

Here is an example of the color gradient selection display.  (Note that the actual color gradients may be different than this example.)

![Mandelbrot Color Gradient Selection View](img/MandelbrotColors.png?raw=true "Mandelbrot Color Gradient Selection View")


### Resizing the Viewer Form

The initial size of the Main Form is designed to fit within an 800 by 600 monitor window.

To enlarge the form, drag its boundary or simply click the _maximize_ icon (small square in the upper right of the title bar).

Then click the **Redraw** button to adjust the graphic viewer area to match the enlarged form.  (The **Reset** button also adjusts the graphic viewer are to match the resized form.)


### Zooming In on a Region of the Mandelbrot Set

Click with the left mouse button anywhere within the graphic viewer are to zoom into the image, centered on that point.

Click with the right mouse button anywhere within the graphic viewer to zoom back out, centered on that point.

Here is an example of the view that has been zoomed in several times on a specific area, and with an alternate color gradient selected.

![Mandelbrot Zoomed View](img/MandelbrotZoomed.png?raw=true "Mandelbrot Zoomed View")


## Source code compilation notes

Download the **Lazarus IDE**, including **Free Pascal**, from  here:

- **<https://www.lazarus-ide.org/index.php?page=downloads>**

After installing the **Lazarus IDE**, clone this GitHub repository to your local disk.
Then double-click on the **src\Mandelbrot.lpr** project file to open it in **Lazarus**. 

_**Note:**_ Using the debugger in the **Lazarus IDE** on Windows 10 _**might**_ require the following configuration adjustment:

- **[Lazarus - Windows - Debugger crashing on OpenDialog](https://www.tweaking4all.com/forum/delphi-lazarus-free-pascal/lazarus-windows-debugger-crashing-on-opendialog/)**

When **Lazarus** includes debugging information the executable file is relatively large.
When ready to create a release executable, the file size can be significantly reduced by selecting the menu item **Project | Project Options ...** and navigating to the **Compile Options | Debugging** tab in the resulting dialog window.
Clear the check-mark from the **Generate info for the debugger** option and then click the **OK** button.
Then rebuild the executable using the **Run | Build** menu item (or using the shortcut key-stroke _**Shift-F9**_).

<a name="ReleaseNotes"></a>

## Release Notes

### Version 1.0.0

This is the initial version of the software.
