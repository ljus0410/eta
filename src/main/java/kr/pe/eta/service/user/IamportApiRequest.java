package kr.pe.eta.service.user;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class IamportApiRequest {

	private static final String VBANK_HOLDER_URL = "https://api.iamport.kr/vbanks/holder";
	private static final String API_URL = "https://api.iamport.kr/users/getToken";
	private static final String API_KEY = "1328754686834150";
	private static final String API_SECRET = "ZEJrrdhn5QGzwJGN3t27bdAiqiHMRDUdYcOIGYGKkR0vheCo0xsibl5zJmShXbMmg30bBe2aVXY6hCNY";

	public String getToken() {
		// Set up the request headers
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		// Set up the request body
		String requestBody = "{\"imp_key\": \"" + API_KEY + "\", \"imp_secret\": \"" + API_SECRET + "\"}";

		// Create an HTTP entity with headers and body
		HttpEntity<String> requestEntity = new HttpEntity<>(requestBody, headers);

		// Make the HTTP POST request
		RestTemplate restTemplate = new RestTemplate();
		System.out.println("url : " + restTemplate.postForObject(API_URL, requestEntity, String.class));
		return restTemplate.postForObject(API_URL, requestEntity, String.class);
	}

	public String getVbankHolder(String accessToken, String bankCode, String bankNum) {
		// Set up the request headers with the access token
		System.out.println("토큰으로 URL 보내기");
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set("Authorization", "Bearer " + accessToken);

		// Set up the request URL with parameters
		String apiUrlWithParams = VBANK_HOLDER_URL + "?bank_code=" + bankCode + "&bank_num=" + bankNum;

		// Create an HTTP entity with headers
		HttpEntity<String> requestEntity = new HttpEntity<>(headers);

		// Make the HTTP GET request
		RestTemplate restTemplate = new RestTemplate();

		// Perform the exchange and get the ResponseEntity
		ResponseEntity<String> responseEntity = restTemplate.exchange(apiUrlWithParams, HttpMethod.GET, requestEntity,
				String.class);

		// Get and print the URL directly from the responseEntity
		String url = apiUrlWithParams; // Assuming apiUrlWithParams is the desired URL
		System.out.println("URL: " + url);

		// Get and return the response body
		return responseEntity.getBody();
	}

	public String JsonParsing(String jsonResponse) {
		String jsonString = jsonResponse;

		try {
			// ObjectMapper를 사용하여 JSON 문자열을 JsonNode로 파싱
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(jsonString);

			// "response" 하위의 "bank_holder" 값 가져오기
			String bankHolderValue = jsonNode.get("response").get("bank_holder").asText();

			/// 결과 출력
			System.out.println("Bank Holder: " + bankHolderValue);

			// 파싱된 값을 반환
			return bankHolderValue;
		} catch (Exception e) {
			e.printStackTrace();
			// 예외가 발생하면 원본 JSON 문자열을 반환하거나 다른 처리를 수행 할 수 있음
			return jsonResponse;
		}
	}
}
