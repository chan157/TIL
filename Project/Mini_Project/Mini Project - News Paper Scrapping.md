# Mini Project - News Paper Scrapping

## 배경

* 하나의 전자신문 회사에서 원하는 키워드에 해당되는 모든 뉴스를 수집 및 저장하는 코드를 작성하라
* 작성 방향 
  * requests와 BeautifulSoup을 통해 파싱을 진행
  * 전체적인 틀을 구조화하여 제작해보도록 한다.
  * 향후에 재사용 또는 변경이 가능하도록 class를 통해 모듈화 한다.
  * 한경신문에만 최적회 되어있는 것이 한계

## Source Code

```python
import re
import requests
from bs4 import BeautifulSoup
        
class newsScrapHK():   # 한국경제신문의 뉴스를 스크랩하는 클래스 
    def __init__(self,query):
        self.query = query  # 검색어
        self.curpage = '1'  # 초기 page는 1페이지
        self.basic_url = "https://search.hankyung.com/apps.frm/search.news?query=" 
        self.url = self.basic_url + self.query + "&page=" + self.curpage  
        							 # 검색어와 page에 맞게 url 설정
        newsScrapHK.make_soup(self)  # BeautifulSoup을 사용해 html parser로 만듬
        newsScrapHK.new_num(self)    # 검색어에 대한 뉴스의 갯수 출력
        self.scrapBox = ""           # 뉴스 스크랩을 위한 문자열
        
    def make_soup(self):   # BeautifulSoup을 사용해 html parser로 만듬
        page = requests.get(self.url).text
        self.soup = BeautifulSoup(page,'html.parser')
        return self.soup
        
    def new_num(self):     # 검색어에 대한 뉴스의 갯수 출력
        new_n = self.soup.find("h3", class_ = 'tit').text  
        match = re.search('[\w\s\W]* (?P<num>[\s\d+\,]*[\d+])[건]',new_n) # 몇 건인지 찾기
        self.new_nums = int(match.group('num').replace(',',''))  # 문자숫자를 정수숫자로 변환
        return self.new_nums
    
    def check_title(self):  # 검색어에 대한 첫 페이지의 뉴스 제목 출력 
        titles = self.soup.find_all('em',class_ = 'tit')
        for i, title in enumerate(titles):
            print('%d : ' % (i+1), title.text.strip())
            
    def page_link(self):  # 현재 page의 뉴스들의 link를 저장
        sel_s = '#content > div.left_cont > div > div.section.hk_news > div > ul > li:nth-of-type('
        sel_e = ") > div > a"     # type 순서대로 모두 선택하기위해 선택자 구분
      
        self.links = []   # 뉴스 링크 저장 공간
        try : 
            for i in range(1,11):   # 한 페이지 당 10개의 뉴스기사가 나오므로
                line = self.soup.select(sel_s + str(i) + sel_e) 
                					# 선택자를 통해 n 번째 링크 가져오기
                self.links.append(line[0].get('href'))
        except IndexError:          # 마지막 페이지나, 10개가 안되는 경우
            pass
        return self.links
    
    def news_scrap(self):   # 현재 저장된 링크에 대한 뉴스 스크랩하기
        self.scrapBox = ""  # 스크랩용 빈공간
        for link in self.links:   # 각 링크를 불러온다
            page1 = requests.get(link).text
            page_soup = BeautifulSoup(page1,'html.parser') # 분석을 위해 parser
            try : 
                article = page_soup.find(id="articletxt").text.strip() # 뉴스 내용 가져오기
            except AttributeError:
                article = "" # 기사 없기 광고만 있는 경우, article배치가 안된경우 패스
            self.scrapBox += ''.join(re.sub('\n|   ',' ',article)) 
            				 # 가져온 article을 scapbox에 차곡차곡
        return self.scrapBox
    
    def change_page_num(self,num):  # 페이지 바꾸고 싶을 때
        self.url = self.basic_url + self.query + "&page=" + str(num)  # 링크 변경
        newsScrapHK.make_soup(self) # 새 페이지에 맞는 html parser
        newsScrapHK.page_link(self) # 새 페이지에 있는 링크들로 갱신

    def change_query(self,query):   # 검색어 바꾸고 싶을 때
        self.query = query          # 검색어 변경
        self.url = self.basic_url + self.query + "&page=" + self.curpage  # 링크 변경
        newsScrapHK.make_soup(self) # 새 페이지에 맞는 html parser
        newsScrapHK.page_link(self) # 새 페이지에 있는 링크들로 갱신
        newsScrapHK.new_num(self)   # 새 검색어에의 news 갯수로 갱신

    def news_scrap_all(self):       # 검색어에 대한 모든 전체 뉴스를 스크랩 하기 위함
        self.scrapBox = ""          # 초기화
        for i in range(1,self.new_nums // 10): # page당 10개씩 있으므로 
            newsScrapHK.change_page_num(self,i)
            newsScrapHK.page_link(self)
            newsScrapHK.news_scrap(self)
        return self.scrapBox
    
    def news2txt(self):             # scrap한 뉴스를 파일로 저장
        with open('newsScraps.txt','w',-1,'utf-8') as f:
            f.write(self.scrapBox)
        print('Done')
            
```

## 결과 실행

```python
hk = newsScrapHK('유가')
hk.new_num()
>>> 83979
hk.check_title()
>>> 1 :  '희대의 탈출극' 곤 닛산 前 회장, 경비업체 감시 중단된 틈 타 도주
    2 :  "곤 前회장, 경비업체 고소 경고로 감시 중단시키고 도주"
    3 :  이란 '호르무즈 봉쇄' 보복하나…국내 기름값 덩달아 불안
    4 :  이란의 '가혹한 보복' 옵션은?…사이버전·원유봉쇄 등 거론
    5 :  이란, 미국에 '최고 보복' 선언…중동위기 다시 최고조
    6 :  美 이란 공습 중동 긴장으로 국제유가 '출렁'…국내 영향은
    7 :  중동 리스크에 금융시장 긴장…금·엔화·원유 값 들썩
    8 :  미-이란 위기에 뉴욕증시 3대지수 동반하락…유가·금값·채권↑
    9 :  뉴욕증시, 중동 정세 일촉즉발…다우, 0.81% 하락 마감
    10 :  美-이란 위기고조에 유가·금값 껑충…WTI 3.1%↑

hk.page_link()
>>> ['https://www.hankyung.com/international/article/2020010423317',
 'https://www.hankyung.com/society/article/202001042288Y',
 'https://www.hankyung.com/economy/article/2020010422587',
 'https://www.hankyung.com/international/article/202001042226Y',
 'https://www.hankyung.com/international/article/2020010421597',
 'https://www.hankyung.com/economy/article/202001042034Y',
 'https://www.hankyung.com/economy/article/202001042024Y',
 'https://www.hankyung.com/international/article/202001042023Y',
 'https://www.hankyung.com/finance/article/202001042012Y',
 'https://www.hankyung.com/international/article/202001041993Y']

hk.change_query('파이썬')
hk.new_nums
>>> 87

hk.news_scrap_all()
>>>'한양사이버대학교가 교육부 재정지원 특성화사업에 세 번 연속 선정됐다.3일 한양사이버대에 따르면 이 대학은 최근 교육부와 한국교육학술정보원이 주관하는 ‘2018년 성인학습자 역량 강화 교육콘텐츠 개발’사업을 수주했다. 2013년 선취업 후진학 지원사업, 2014년 NCS특성화 지원사업에 이어 세 번 연속으로 정부 재정지원사업에 선정됐다. 한양사이버대는 이날 한국교육학술정보원과 사업 계약과 관련한 협상을 마무리 짓고 본격적인 사업에 착수했다.‘성인 학습자 역량 강화 교육 콘텐츠 개발 사업’은 사이버대학이 생애주기별로 성인학습자에게 필요한 교육과정을 제공할 수 있도록 정부가 지원하는 사업이다. 올해는 전국 21개 사이버대학 중 8 ...'  # 중략

hk.news2txt()
>>> Done
```

