package com.paftp.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.paftp.service.Count.CountService;
import com.paftp.service.sut.SutService;
import com.paftp.service.version.VersionService;
import com.paftp.util.SSHClient;
import com.paftp.dto.MsgDto;
import com.paftp.dto.SmsDto;
import com.paftp.entity.Sut;
import com.paftp.entity.User;
import com.paftp.entity.Version;

@Controller
public class VerifyCodeAction extends ActionSupport {

	private static final long serialVersionUID = -3711384709023965402L;
	
	private String number;
	private String stg;
	private List<SmsDto> smsCodes ;
	private List<MsgDto> msgs ;


	private Long count;
	private int countId;
	
	@Resource
	private CountService countService;
	
	public String getQueryCount(){
		this.setCount(countService.getCount(this.countId));
		return SUCCESS;
	}
	
	public String querySmsCode() {
		countService.addCount(1);
		
		SSHClient ssh = new SSHClient();
		String url = "";
		if(stg.equals("stg1")){
			url = "192.168.36.64:1532:t2pay";
		}else if(stg.equals("stg2")){
			url = "192.168.36.64:1537:t3pay";
		}else if(stg.equals("stg3")){
			url = "192.168.213.237:11521:t3pay";
		}else if(stg.equals("stg5")){
			url = "t5pay.dbstg.papay.com.cn:1532:t5pay";
		}else{
			return "error";
		}
		
		List<SmsDto> smsdtos = new ArrayList<SmsDto>();
		
		try {
			Boolean success = ssh.connect("192.168.21.172", "wls81", "Paic#234");
			if(success){
				String s = ssh.execute("sh /wls/wls81/PAFTPTools/querySmsCode.sh " + url + " " +  number + " 1");
				String[] results = s.split("&");
				for(int i=0;i<results.length;i++){
					String[] record = results[i].split("#");
					SmsDto sms = new SmsDto();
					sms.setPhoneNum(record[0]);
					sms.setCode(record[1]);
					sms.setTemplate(record[2]);
					sms.setTime(record[3]);
					smsdtos.add(sms);
				}
				
			}else {
				return "error";
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			ssh.close();
			return "error";
		}
		ssh.close();
		this.setCount(countService.getCount(1));
		this.setSmsCodes(smsdtos);
		return SUCCESS;
	}


	public String queryMsg() {
		countService.addCount(2);
		
		SSHClient ssh = new SSHClient();
		String url = "";
		if(stg.equals("stg1")){
			url = "192.168.36.64:1532:t2pay";
		}else if(stg.equals("stg2")){
			url = "192.168.36.64:1537:t3pay";
		}else if(stg.equals("stg3")){
			url = "192.168.213.237:11521:t3pay";
		}else if(stg.equals("stg5")){
			url = "t5pay.dbstg.papay.com.cn:1532:t5pay";
		}else{
			return "error";
		}
		
		List<MsgDto> msgdtos = new ArrayList<MsgDto>();
		
		try {
			Boolean success = ssh.connect("192.168.21.172", "wls81", "Paic#234");
			if(success){
				String s = ssh.execute("sh /wls/wls81/PAFTPTools/querySmsCode.sh " + url + " " +  number + " 2");
				String[] results = s.split("&");
				for(int i=0;i<results.length;i++){
					String[] record = results[i].split("#");
					MsgDto msg = new MsgDto();
					msg.setPhoneNum(record[0]);
					msg.setChannel(record[1]);
					msg.setTemplate(record[2]);
					msg.setMsg(record[3]);
					msg.setTime(record[4]);
					msgdtos.add(msg);
				}
				
			}else {
				return "error";
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			ssh.close();
			return "error";
		}
		ssh.close();
		this.setCount(countService.getCount(2));
		this.setMsgs(msgdtos);
		return SUCCESS;
	}

	
	public List<SmsDto> getSmsCodes() {
		return smsCodes;
	}


	public void setSmsCodes(List<SmsDto> smsCodes) {
		this.smsCodes = smsCodes;
	}

	public List<MsgDto> getMsgs() {
		return msgs;
	}

	public void setMsgs(List<MsgDto> msgs) {
		this.msgs = msgs;
	}
	
	public String getNumber() {
		return number;
	}


	public void setNumber(String number) {
		this.number = number;
	}


	public String getStg() {
		return stg;
	}


	public void setStg(String stg) {
		this.stg = stg;
	}


	public Long getCount() {
		return count;
	}


	public void setCount(Long count) {
		this.count = count;
	}

	public int getCountId() {
		return countId;
	}

	public void setCountId(int countId) {
		this.countId = countId;
	}



}
