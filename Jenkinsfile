node {
  checkout scm
  sh """
mkdir -p ./test/results
docker-compose -f docker-compose.test.yml build sut
docker-compose -f docker-compose.test.yml run sut
"""
  step([$class: 'JUnitResultArchiver', testResults: '**/test/results/TEST*.xml'])
}
