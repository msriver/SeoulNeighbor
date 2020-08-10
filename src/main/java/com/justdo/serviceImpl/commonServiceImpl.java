package com.justdo.serviceImpl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.justdo.domain.MemberVO;
import com.justdo.mapper.BoardMapper;
import com.justdo.mapper.commonMapper;
import com.justdo.service.commonService;

import lombok.AllArgsConstructor;


@AllArgsConstructor
@Service("commonService")
public class commonServiceImpl implements commonService {
	
	private commonMapper mapper;
	private BoardMapper boardMapper;
	private JavaMailSender mailSender;
	
	//로그인
	@Override
	public MemberVO login(MemberVO vo) {
		return mapper.login(vo);
	}
	

	@Override
	public int likeBoard(int bno) {
		// TODO Auto-generated method stub
		boardMapper.like(bno);
	      return boardMapper.selectLikeCount(bno);
      }

	@Override
	public int unlikeBoard(int bno) {
		// TODO Auto-generated method stub
		boardMapper.unlike(bno);
	      return boardMapper.selectUnlikeCount(bno);
	}
	
	//회원가입 
	@Override
	public void join(MemberVO vo) {
		mapper.insertUser(vo);
		mapper.insertUserAuth(vo.getUserid());
	}

	//아이디 중복체크
	@Override
	public boolean isUniqueID(String userId) {
		if(mapper.checkID(userId) == 0) {
			return true;
		}
		return false;
	}

	//닉네임 중복체크
	@Override
	public boolean isUniqueNickName(String nickName) {
		if(mapper.checkNickName(nickName) == 0) {
			return true;
		}
		return false;
	}

	@Override
	public boolean isUniqueEmail(String email) {
		if(mapper.checkEmail(email) == 0) {
			return true;
		}
		return false;
	}

	@Override
	public int selectMessageReadCount(String userid) {
		return mapper.selectMessageReadCount(userid);
	}

	@Override
	public boolean remove(int bno) {
		return boardMapper.delete(bno)==1;
	}

	@Override
	public String selectGuForWeather(String userid) {
		return mapper.selectGuForWeather(userid);
	}

	@SuppressWarnings("deprecation")
	@Override
	public String[] getWeather(String gu) throws IOException {
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyMMdd");
		SimpleDateFormat hourFormat = new SimpleDateFormat("HH");
		String today = dateFormat.format(date);
		String todayHour = hourFormat.format(date);
		String apiUrl = "http://apis.data.go.kr/1360000/VilageFcstInfoService/getVilageFcst";
		// 홈페이지에서 받은 키
		String serviceKey = "0a%2BsATcqfSi69BN%2Fz4gXhd%2BVbPgLPenFhWceGZGW5KImNgeyJ%2Bv27NhAOEqNXRHEvmBPLXzDaZ0sBTDHNplZIQ%3D%3D";
		String nx = "60";	//위도
		String ny = "125";	//경도

		String baseDate = today;	//조회하고싶은 날짜
		String baseTime = "0500";	//조회하고싶은 시간
		String type = "json";	//타입 xml, json 등등 ..
		
		if(Integer.parseInt(todayHour) >=2 && Integer.parseInt(todayHour) <5) {
			baseTime = "0200";
		}
		else if(Integer.parseInt(todayHour) >=5 && Integer.parseInt(todayHour) <8) {
			baseTime = "0500";
		}
		else if(Integer.parseInt(todayHour) >=8 && Integer.parseInt(todayHour) <11) {
			baseTime = "0800";
		}
		else if(Integer.parseInt(todayHour) >=11 && Integer.parseInt(todayHour) <14) {
			baseTime = "1100";
		}
		else if(Integer.parseInt(todayHour) >=14 && Integer.parseInt(todayHour) <17) {
			baseTime = "1400";
		}
		else if(Integer.parseInt(todayHour) >=17 && Integer.parseInt(todayHour) <20) {
			baseTime = "1700";
		}
		else if(Integer.parseInt(todayHour) >=20 && Integer.parseInt(todayHour) <23) {
			baseTime = "2000";
		}
		else if(Integer.parseInt(todayHour) >=23 || Integer.parseInt(todayHour) <2) {
			baseTime = "2300";
		}
		else {
			baseTime ="2300";
		}
		if(gu == null) {
			nx = "60"; //중구
			ny = "127";
		}
		else if(gu.equals("양천구")) {
			nx = "58";
			ny = "126";
		}
		else if(gu.equals("종로구")) {
			nx = "50";
			ny = "127";
		}
		else if(gu.equals("용산구")) {
			nx = "60";
			ny = "126";
		}
		else if(gu.equals("성동구")) {
			nx = "61";
			ny = "127";
		}
		else if(gu.equals("광진구")) {
			nx = "52";
			ny = "126";
		}
		else if(gu.equals("동대문구")) {
			nx = "61";
			ny = "127";
		}
		else if(gu.equals("중랑구")) {
			nx = "62";
			ny = "128";
		}
		else if(gu.equals("성북구")) {
			nx = "61";
			ny = "127";
		}
		else if(gu.equals("강북구")) {
			nx = "61";
			ny = "128";
		}
		else if(gu.equals("도봉구")) {
			nx = "61";
			ny = "129";
		}
		else if(gu.equals("노원구")) {
			nx = "61";
			ny = "129";
		}
		else if(gu.equals("은평구")) {
			nx = "59";
			ny = "127";
		}
		else if(gu.equals("서대문구")) {
			nx = "59";
			ny = "127";
		}
		else if(gu.equals("마포구")) {
			nx = "59";
			ny = "127";
		}
		else if(gu.equals("강서구")) {
			nx = "58";
			ny = "126";
		}
		else if(gu.equals("구로구")) {
			nx = "58";
			ny = "125";
		}
		else if(gu.equals("금천구")) {
			nx = "59";
			ny = "124";
		}
		else if(gu.equals("영등포구")) {
			nx = "58";
			ny = "126";
		}
		else if(gu.equals("동작구")) {
			nx = "59";
			ny = "125";
		}
		else if(gu.equals("관악구")) {
			nx = "59";
			ny = "125";
		}
		else if(gu.equals("서초구")) {
			nx = "61";
			ny = "125";
		}
		else if(gu.equals("강남구")) {
			nx = "61";
			ny = "126";
		}
		else if(gu.equals("송파구")) {
			nx = "62";
			ny = "126";
		}
		else if(gu.equals("강동구")) {
			nx = "62";
			ny = "126";
		}
		
        StringBuilder urlBuilder = new StringBuilder(apiUrl);
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "="+serviceKey);
        urlBuilder.append("&" + URLEncoder.encode("nx","UTF-8") + "=" + URLEncoder.encode(nx, "UTF-8")); //경도
        urlBuilder.append("&" + URLEncoder.encode("ny","UTF-8") + "=" + URLEncoder.encode(ny, "UTF-8")); //위도
        urlBuilder.append("&" + URLEncoder.encode("base_date","UTF-8") + "=" + URLEncoder.encode(baseDate, "UTF-8")); /* 조회하고싶은 날짜*/
        urlBuilder.append("&" + URLEncoder.encode("base_time","UTF-8") + "=" + URLEncoder.encode(baseTime, "UTF-8")); /* 조회하고싶은 시간 AM 02시부터 3시간 단위 */
        urlBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode(type, "UTF-8"));	/* 타입 */
        
        /*
         * GET방식으로 전송해서 파라미터 받아오기
         */
        URL url = new URL(urlBuilder.toString());
        //어떻게 넘어가는지 확인하고 싶으면 아래 출력분 주석 해제
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        //System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        String result= sb.toString();
        

        JsonObject weather=null;
        JsonObject temperature=null;
        JsonObject isRain=null;
        
        String nowWeather="";
        String nowTemperature="";
        
        try {
        //jsonparser로 문자열 객체화
        JsonParser parser = new JsonParser();
        JsonObject obj = (JsonObject) parser.parse(result);
        
        JsonObject parseResponse = (JsonObject) obj.get("response");
        JsonObject parseBody = (JsonObject) parseResponse.get("body");
        JsonObject parseItems = (JsonObject) parseBody.get("items");
        
        //items에서 item 배열로 받아옴
        JsonArray parseItem = (JsonArray) parseItems.get("item");
        

        
        for(int i=0; i<parseItem.size(); i++) {
        	JsonObject temp = (JsonObject) parseItem.get(i);
        	if(temp.get("category").getAsString().equals("SKY")) {
        		weather = (JsonObject) parseItem.get(i);
        	}
        	else if(temp.get("category").getAsString().equals("T3H")) {
        		temperature = (JsonObject) parseItem.get(i);
        	}
        	else if(temp.get("category").getAsString().equals("PTY")) {
        		isRain = (JsonObject) parseItem.get(i);
        	}
        }

        
		 
		nowTemperature=temperature.get("fcstValue").getAsString();
		
		
		if(isRain.get("fcstValue").getAsInt()==0) {
			if(weather.get("fcstValue").getAsInt()==1) {
				nowWeather = "맑음";
			}
			else if(weather.get("fcstValue").getAsInt()==3) {
				nowWeather = "구름많음";
			}
			else if(weather.get("fcstValue").getAsInt()==4) {
				nowWeather = "흐림";
			}
		}
		else if(isRain.get("fcstValue").getAsInt()==1){
			if(isRain.get("fcstValue").getAsInt()==1) {
				nowWeather = "비";
			}
			else if(isRain.get("fcstValue").getAsInt()==2) {
				nowWeather = "비/눈";
			}
			else if(isRain.get("fcstValue").getAsInt()==3) {
				nowWeather = "눈";
			}
			else if(isRain.get("fcstValue").getAsInt()==4) {
				nowWeather = "소나기";
			}
			else if(isRain.get("fcstValue").getAsInt()==6) {
				nowWeather = "진눈개비";
			}
			else{
				nowWeather = "눈날림";
			}
		}
        }catch(NullPointerException e) {
        	e.printStackTrace();
        }


		String[] weatherData = {nowWeather,nowTemperature,gu};
        
        return weatherData;
	}
	
	//문화정보 받아오기 ////////////////////////////////
	@SuppressWarnings("deprecation")
	@Override
	public String[] getCulture() throws IOException {
		String apiUrl = "http://openapi.seoul.go.kr:8088/706c7563486767613930667662646c/json/culturalEventInfo/1/10";        
        /*
         * GET방식으로 전송해서 파라미터 받아오기
         */
        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json; charset=utf-8");
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        String result= sb.toString();
        
        //jsonparser로 문자열 객체화
        JsonParser parser = new JsonParser();
        JsonObject obj = (JsonObject) parser.parse(result);
        
        JsonObject parseResponse = (JsonObject) obj.get("culturalEventInfo");
        JsonArray parseItems = (JsonArray) parseResponse.get("row");
        int randInt = (int)((Math.random())*9);

        JsonObject tempCultureInfo = (JsonObject)parseItems.get(randInt);
        String temp = tempCultureInfo.get("MAIN_IMG").getAsString();
        if(temp.lastIndexOf("http")>0) {
        	temp = temp.substring(temp.lastIndexOf("http"));
        }
        String[] culutreInfo = {tempCultureInfo.get("TITLE").getAsString(),tempCultureInfo.get("DATE").getAsString(),tempCultureInfo.get("PLACE").getAsString(),tempCultureInfo.get("ORG_LINK").getAsString(),temp};
		return culutreInfo;
        
	}
	//문화 정보 받아오기//


	//새소식 받아오기
	@SuppressWarnings("deprecation")
	@Override
	public JsonArray getNews() throws IOException {
		String apiUrl = "http://openapi.seoul.go.kr:8088/706c7563486767613930667662646c/json/SeoulNewsList/1/5/";        
        /*
         * GET방식으로 전송해서 파라미터 받아오기
         */
        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json; charset=utf-8");
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        String result= sb.toString();
        
        //jsonparser로 문자열 객체화
        JsonParser parser = new JsonParser();
        JsonObject obj = (JsonObject) parser.parse(result);
        
        JsonObject parseResponse = (JsonObject) obj.get("SeoulNewsList");
        JsonArray parseItems = (JsonArray) parseResponse.get("row");

		return parseItems;
	}

	
	//이메일로 회원 아이디 찾기
	@Override
	public String findIdByEmail(String email) {
		return mapper.findID(email);
	}

	@Override
	public String changePassword(String userid, String email, String userpw) {
		mapper.updateNewPassword(userid, email, userpw);
		return "true";
	}


	@Override
	public void commonMailSender(String setfrom, String tomail, String title, String content) throws MessagingException {
		
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		 
		messageHelper.setFrom(setfrom);
		messageHelper.setTo(tomail);
		messageHelper.setSubject(title);
		messageHelper.setText(content);
		
		mailSender.send(message);
	}

}
