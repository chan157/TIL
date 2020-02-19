library(arules)
data(Epub)

Epub
summary(Epub)
"""
15729 rows : 책 빌린 경우의 수
939 columns : 책 종류

doc_11d : 가장 많이 빌린 책 356건
doc_813 : 두 번쨰 많이 빌려진 책 329건

책을 빌려간 권 수
1권 : 11615건
~
최대 58권 : 1건
"""
inspect(Epub[1:10])

itemFrequency(Epub[1:100,])
itemFrequencyPlot(Epub, topN=20)
image(Epub)
image(sample(Epub,1000))

EpubRules <- apriori(Epub,
                     parameter = list(support=0.001,
                                      confidence=0.02,
                                      minlen=2))
EpubRules
summary(EpubRules)
head(inspect(EpubRules))
head(inspect(sort(EpubRules, by='lift')))
head(inspect(sort(EpubRules, by='count')))
head(inspect(sort(EpubRules, by='confidence')))
head(inspect(sort(EpubRules, by='support')))

doc_6e7_Rules <- 
  subset(EpubRules, items %in% 'doc_6e7') # berries가 포함된 모든 규칙을찾아라
inspect(sort(doc_6e7_Rules,by='lift'))

doc_6e89_Rules <- 
  subset(EpubRules, items %in% 'doc_6e8','doc_6e9')
inspect((doc_6e89_Rules))

Epub_df <- as(EpubRules, 'data.frame')
Epub_df
head(Epub_df)

plot(Epub_df$support)

ecl <- eclat(Epub,parameter=list(
  support=5/15729,minlen=2,maxlen=100))

inspect(head(sort(ecl,by='support')))



