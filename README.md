PLEASE READ THE LICENSE FILE FOR LICENSE INFORMATION.

This is a ground truth dataset for mass spectrometry data analysis at the MS1 signal level comprised of isolated peptide signals from UPS2.

The dataset consists of > 28m points, > 1.2m of which are grouped into extracted ion chromatograms, and those grouped into isotopic envelopes.

This data set can be used to evaluate many aspects of mass spectrometry data processing, including precursor mapping and signal extraction algorithms.

The original study is described in Tsou et al 2015 and is available in PRIDE repository PXD001587 under filename 18185_REP2_4pmol_UPS2_IDA_1.mzXML

The intact file is larger than the max file size on Github, so the file is split into 100MB chunks, with the index in the filename: v<version>.<index>.csv

To re-assemble the files, simply navigate to the v1_0 folder and run the command: "ruby assemble2.rb". The assembled file will be created in that folder and be named v1_0.csv.

The schema of the .csv is as follows:
point_id,m/z,RT,intensity,XIC_id,isotopic_envelope_id

An XIC_id of 0 or -1 indicates the point was assigned as noise.

Please cite this paper if you use the data:
https://pubs.acs.org/doi/abs/10.1021/acs.jproteome.8b00659
