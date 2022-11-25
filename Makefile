all: begin $(DOCSET) $(DOCSET).docset

# Check that DOCSET is set
.PHONY: begin
begin:
ifndef DOCSET
	$(error Error: DOCSET is not defined)
endif

# Get DOCSET from system files
$(DOCSET): getters/$(DOCSET).sh
	rm -rf $(DOCSET)
	getters/$(DOCSET).sh

# Convert to dash docset using python script
$(DOCSET).docset: $(DOCSET) mandocset.py
	rm -rf "$(DOCSET).docset"
ifndef EXECUTABLE
	python3 mandocset.py -o $(DOCSET) -p $(DOCSET)/
else
	python3 mandocset.py -o $(DOCSET) -p $(DOCSET)/ -e "$(EXECUTABLE)"
endif

# Remove generated files/directories
.PHONY: clean
clean: begin
	rm -rf $(DOCSET)
	rm -rf $(DOCSET).docset
	rm -rf $(DOCSET).tgz

# Create .tgz archive of generated docset directory
.PHONY: tgz
tgz: begin $(DOCSET).tgz
$(DOCSET).tgz: $(DOCSET).docset
	tar --exclude='.DS_Store' -cvzf $(DOCSET).tgz $(DOCSET).docset
