#!/usr/bin/env perl
use strict;
use warnings;
use HTML::TreeBuilder;
use Data::Dumper; # For optional debugging output
use Text::CSV qw(csv);

# Prerequisite:
# Open AP4 workspace in EDX and navigate to the EDX Drive for
# industry/ap4/Info_Matrix and industry/ap4/Matrix. These sites will
# have 64 and 97 resources, respectively. Use the development window in
# your browser to export this HTML, save it to an .html file, and run
# this script to create the CSV files of resource IDs and names.

# Check if any HTML files were provided as command-line arguments
if (@ARGV == 0) {
    die "Usage: $0 <file1.html> [file2.html ...]\n";
}

my $output_file;
my @html_files;


# Parse command-line arguments
for (my $i = 0; $i < @ARGV; $i++) {
    if ($ARGV[$i] eq '--output' && $i + 1 < @ARGV) {
        $output_file = $ARGV[$i + 1];
        $i++; # Skip the next argument (the filename)
    } else {
        push @html_files, $ARGV[$i];
    }
}

unless (defined $output_file) {
    die "Error: Please specify an output CSV file using --output <filename.csv>\n";
}

# Open the output CSV file for writing
open my $csv_fh, '>', $output_file or die "Could not open $output_file for writing: $!";

# Create a new CSV object
my $csv = Text::CSV->new();

# Write the header row to the CSV file
$csv->say($csv_fh, [ 'filename', 'resource_id', 'resource_name' ]);

# Iterate through each HTML file provided
foreach my $html_file (@html_files) {
    print "Processing file: $html_file\n";

    # Parse the HTML file into a tree structure
    my $tree = HTML::TreeBuilder->new_from_file($html_file)
        or die "Could not parse $html_file: $!";

    # Find all <div> elements that have the 'data-resource' attribute
    my @divs = $tree->look_down('_tag', 'div', 'data-resource', qr/.+/);

    # Iterate through the found <div> elements and extract the data
    foreach my $div (@divs) {
        my $resource_id = $div->attr('data-resource');
        my $resource_name = $div->attr('data-name');

        if (defined $resource_id && defined $resource_name) {
            $csv->say($csv_fh, [ $html_file, $resource_id, $resource_name ]);
        }
    }

    # Clean up the tree structure to free memory
    $tree->delete;
}

# Close the output CSV file
close $csv_fh or die "Could not close $output_file: $!";

print "Extracted data saved to $output_file\n";
