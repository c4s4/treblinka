TITLE=L'enfer de Treblinka
AUTHOR=Vassili Grossman
NAME=$(AUTHOR) - $(TITLE)
BUILD_DIR=build

YEL="\\033[93m"
END="\\033[0m"

default: clean pdf epub publish

help: # Print help on Makefile
	@grep '^[^.]\+:\s\+.*#' Makefile | sed "s/\(.\+\):\s*\(.*\) #\s*\(.*\)/`printf "\033[93m"`\1`printf "\033[0m"`	\3 [\2]/" | expand -t20

pdf: # Generate PDF format
	@echo "$(YEL)Generating PDF format$(END)"
	@mkdir -p $(BUILD_DIR)
	@md2pdf -o "$(BUILD_DIR)/$(NAME).pdf" README.md

epub: # Generate EPUB format
	@echo "$(YEL)Generating EPUB format$(END)"
	@mkdir -p $(BUILD_DIR)
	@pandoc -o "$(BUILD_DIR)/$(NAME).epub" README.md

clean: # Clean generated files
	@echo "$(YEL)Cleaning generated files$(END)"
	@rm -rf $(BUILD_DIR)

release: # Perform a release
	@echo "$(YEL)Performing a release$(END)"
	@read -p "Version: " VERSION; \
	git tag -a $${VERSION} -m  "Release $${VERSION}"; \
	git push origin $${VERSION}

publish: # Publish on website
	@echo "$(YEL)Publishing on website$(END)"
	@scp $(BUILD_DIR)/* sweetohm.net:/home/web/public/
