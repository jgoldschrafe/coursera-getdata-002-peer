# run_analysis.R
# Author: Jeff Goldschrafe

projectDir = '.'

# Optionally, hardcode projectDir path
#projectDir <- "/path/to/project"

dataDir <- file.path(projectDir, 'dataset')
inputDatasetNames <- c('test', 'train')
activityLabels.path <- file.path(dataDir, 'activity_labels.txt')
features.path <- file.path(dataDir, 'features.txt')
subject.paths = paste0(dataDir, '/', inputDatasetNames, '/subject_', inputDatasetNames, '.txt')
X.paths = paste0(dataDir, '/', inputDatasetNames, '/X_', inputDatasetNames, '.txt')
y.paths = paste0(dataDir, '/', inputDatasetNames, '/y_', inputDatasetNames, '.txt')
output.path = file.path(projectDir, 'result.txt')

mergeDatasets <- function (list) {
  do.call('rbind', list)
}

readDataset <- function (path) {
  read.table(path, header = FALSE, stringsAsFactors = FALSE)
}

readDatasets <- function (paths) {
  lapply(paths, readDataset)
}

writeDataset <- function (dataset, path) {
  write.table(dataset, path, row.names = FALSE)
}

# Read data from disk
activityLabels <- readDataset(activityLabels.path)
colnames(activityLabels) <- c('activityID', 'activityLabel')
features <- readDataset(features.path)
colnames(features) <- c('featureID', 'featureLabel')

subject.datasets <- readDatasets(subject.paths)
X.datasets <- readDatasets(X.paths)
y.datasets <- readDatasets(y.paths)

# Merge datasets
subject.mergedDataset <- mergeDatasets(subject.datasets)
colnames(subject.mergedDataset) <- 'subjectID'
X.mergedDataset <- mergeDatasets(X.datasets)
colnames(X.mergedDataset) <- features$featureLabel
y.mergedDataset <- mergeDatasets(y.datasets)
colnames(y.mergedDataset) <- 'activityID'

# Correlate participant ID and position data back to dataset
y.mergedActivityLabels <- sapply(y.mergedDataset[, 1], function (activityNumber) {
  activityLabels[activityNumber, 2]
})
wantedColNames <- grep('(mean|std)', colnames(X.mergedDataset), value = TRUE)
X.mergedSubset <- X.mergedDataset[, wantedColNames]

dataset <- data.frame(subject.mergedDataset, y.mergedActivityLabels,
                      X.mergedSubset, stringsAsFactors = FALSE)

# The above data.frame() call is not respecting stringsAsFactors option, because R
colnames(dataset) <- c('subjectID', 'activityLabel', colnames(X.mergedSubset))

aggregatedDataset <- aggregate(dataset[, 3:ncol(dataset)],
                               list(subjectID = dataset$subjectID,
                                    activityLabel = dataset$activityLabel), mean)
writeDataset(aggregatedDataset, output.path)