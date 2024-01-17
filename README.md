## PDF Converter

<p align="center">
    <a href="https://savelife.in.ua/en/" alt="ComeBackAlive">
        <img src="https://img.shields.io/badge/ComeBackAlive-%E2%9D%A4-ff69b4.svg" /></a>
    <a href="https://sonarcloud.io/api/project_badges/measure?project=ivasik-k7_pdf_converter&metric=alert_status"
        alt="Quality Gate Status">
        <img src="https://sonarcloud.io/api/project_badges/measure?project=ivasik-k7_pdf_converter&metric=alert_status"
            alt="Quality Gate Status"></a>
</p>

A simple script that converts AsciiDoc files to PDF files.

### Usage

```bash
ruby main.rb /path/to/input/folder /path/to/output/folder
```

Where `/path/to/input/folder` is the directory containing the AsciiDoc files you want to convert, and `/path/to/output/folder` is the directory where you want to save the PDF files.

### Options

- `imagesdir`: The directory where AsciiDoc images are stored. (default:`cache`)
- `preface-title`: The title of the preface. (default: `Preface`)
- `icons`: The icons style. (default: `font`)
- `doctype`: The document type. (default: `article`)
- `source-highlighter`: The source highlighter. (default: `rouge`)
- `rouge-style`: The Rouge style. (default: `monokai`)

### Installation

1. Install Ruby.

```bash
# make sure that the ruby has been installed
ruby --version
```

2. Clone this repository:

```bash
git clone https://github.com/ivasik-k7/pdf_converter.git
```

3. Run the dependencies installation script:

```bash
bash install.sh
```

4. Run the script itself

```bash
ruby main.rb /path/to/input/folder /path/to/output/folder
```

### License

This project is licensed under the MIT License.
