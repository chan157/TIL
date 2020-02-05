from openpyxl import Workbook
import re
import requests
from bs4 import BeautifulSoup
import datetime


class DaumNewsScrap():
	def __init__(self, query, start=20200109000000, end=20200204192426, page=1):
		self.query = query
		self.page = page
		self.start = start
		self.end = end
		self.url1 = "https://search.daum.net/search?w=news&enc=utf8&cluster=y&cluster_page=1&q={query}"
		self.url2 = "&p={page}&period=u&sd={start}&ed={end}"
		self.url_total = self.url1 + self.url2
		DaumNewsScrap.number_of_news(self)

	def page_url(self, page=1):
		"""
		각 페이지 url 설정하는 부분, Daum에서 키워드 검색 후 뉴스 탭에서 페이지를 한 페이지씩 넘어가기 위해
		"""
		self.url = self.url_total.format(query=self.query, page=page,
		                                 start=self.start, end=self.end)
		return self.url

	def number_of_news(self):
		"""
		검색어에 대한 뉴스 총 개수 확인,
		뉴스 페이지 당 10개씩 뉴스 기사가 업로드 되므로
		total_num//10 만큼 페이지를 돌아가면됨
		:return: total_num
		"""

		url = DaumNewsScrap.page_url(self)
		page = requests.get(url).text
		soup = BeautifulSoup(page, 'html.parser')

		pat = re.compile("<a")
		count_pat = re.compile("약* ([0-9\,]*)건")
		number = soup.find_all('span', id='resultCntArea')[0].text
		total_num = count_pat.findall(number)[0]
		self.total_num = int(total_num.replace(",", ""))
		return self.total_num

	def news_scrap(self):
		"""
		뉴스 스크랩 한 후 엑셀파일에 작성하는 부분
		csv나 encoding 잘 모르겠어서 그냥 xlsx 로 저장했음
		:return: 최종 결과물 파일 저장
		"""
		# 총 반복 횟수 설정
		number_of_repeat = self.total_num // 10
		# 엑셀 파일 열기
		write_wb = Workbook()
		write_ws = write_wb.active
		write_ws.append(['날짜', '언론사', '기사'])  # column명 설정

		# 본격 적인 뉴스 스크랩
		news_total_scrap = ""
		for i in range(1, number_of_repeat):
			DaumNewsScrap.page_url(self, i)
			link = self.url
			soup = BeautifulSoup((requests.get(link).text), 'html.parser')
			url_soups = soup.select('span.f_nb.date > a.f_nb')
			# url_soups에 10개의 뉴스 기사의 링크가 들어감

			print(i, '/', number_of_repeat - 1)  # 진행 정도
			for url in url_soups:
				# 뉴스기사의 url, 각 뉴스 기사 링크로 들어가서 기사 파싱해오기
				url = url.get('href')
				soup = BeautifulSoup(requests.get(url).text, 'html.parser')

				# 날짜 구하기
				try:
					date_find = soup.select('div > span > span:nth-child(2)')[0].text
				except:
					date_find = soup.select('div > span > span')[0].text

				re_date = re.compile("(\d\d\d\d\.\d\d\.\d\d)")
				date = re_date.findall(date_find)[0]
				date = datetime.datetime.strptime(date, '%Y.%m.%d')

				# 언론사명 구하기
				media_name = soup.select('div > em > a > img')[0].get('alt')

				# 기사내용 긁어오기
				contents = soup.find_all('p')
				temp = []
				for sentence in contents:
					temp.append(sentence.text)  # 한 기사 통쨰로 만들기
					write_ws.append([date, media_name, sentence.text])  # 문장 단위로 저장하기

				news_total_scrap += "".join(temp)

				write_wb.save('Scrap_test.xlsx')

		return news_total_scrap




