# Carleton University LaTeX Thesis Document Class

This project is my attempt at writing a LaTeX document class that conforms to Carleton Universities [thesis formatting requirements](https://gradstudents.carleton.ca/resources-page/thesis-requirements/formatting-guidelines/). There are a few existing implementations (for example, this one by [Babak Esfandiari](http://www.sce.carleton.ca/faculty/esfandiari/ThesisTemplate.zip) that I largely based this implementation off of) of a thesis template for Carleton Students, but they either fail to integrate nicely with existing LaTeX classes, or they clash with certain LaTeX packages, or they fail to meet Carleton's formatting guidelines. 

This package offers:
- Integration with LaTeX's `book` class, and optionally `scrbook`
- Implementation as a LaTeX document class (not a package, or a messy single TeX file that acts as a template)
- Some more features are planned, those are coming soon 😁

## Usage

See [test.tex](./test.tex) for a simple MWE of how to use this document class. `cu-thesis.cls` will either need to be installed in your tex path or placed in the same directory as your thesis. 

## Contributing

Contributions are welcome. If you have an idea, feel free to open an issue or create a PR.

## Developing

The class is implemented alongside its implementation in [cu-thesis.dtx](./cu-thesis.dtx). You will need familiarity with working with the [docstrip](https://www.ctan.org/pkg/docstrip) utility. Building changes made to the `.dtx` file is done by running `make`. The build process causes the `.dtx` file to output a `.ins` and `.cls` file. 
