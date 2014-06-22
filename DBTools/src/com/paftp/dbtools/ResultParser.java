package com.paftp.dbtools;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.paftp.bean.*;

public class ResultParser {

	public Testpass getTestpass(String path) {

		Testpass testpass = new Testpass();

		Properties p = this.getProperties(path + "\\testpass.properties");
		testpass.setSut_name(p.getProperty("sut"));
		testpass.setVersion_name(p.getProperty("version"));
		testpass.setTestset(p.getProperty("testset"));
		File[] files = this.getFiles(path + "\\result\\");
		List<TestsuiteResult> testsuite_results = new ArrayList<TestsuiteResult>();
		for (int i = 0; i < files.length; i++) {
			TestsuiteResult testsuite_result = this.getTestsuiteResult(path
					+ "\\result\\" + files[i].getName());
			testsuite_results.add(testsuite_result);
		}
		testpass.setTestsuite_results(testsuite_results);
		return testpass;
	}

	public TestsuiteResult getTestsuiteResult(String path) {
		TestsuiteResult testsuite_result = new TestsuiteResult();
		String filename = this.getFileName(path);
		String testsuiteresult_names[] = filename.split("\\.");
		String testsuiteresult_name = testsuiteresult_names[0];
		testsuite_result.setSuitename(testsuiteresult_name);
		Document xmlDoc = this.getXmlFile(path);
		Element root = xmlDoc.getDocumentElement();
		NodeList list = root.getChildNodes();
		List<TestcaseResult> testcase_results = new ArrayList<TestcaseResult>();
		for (int i = 0; i < list.getLength(); i++) {
			if (list.item(i) instanceof Element) {
				Element testcaseNode = (Element) list.item(i);
				TestcaseResult testcase_result = this
						.getTestcaseResult(testcaseNode);
				testcase_results.add(testcase_result);
			}
		}
		testsuite_result.setTestcase_results(testcase_results);
		return testsuite_result;
	}

	public TestcaseResult getTestcaseResult(Element testcaseElement) {
		TestcaseResult testcase_result = new TestcaseResult();
		testcase_result.setCasename(testcaseElement.getAttribute("name"));
		if (testcaseElement.getAttribute("result").equals("0")) {
			testcase_result.setIspass(true);
		} else {
			testcase_result.setIspass(false);
		}

		NodeList list = testcaseElement.getChildNodes();
		List<TestcaseResultContent> testcaseresult_contents = new ArrayList<TestcaseResultContent>();
		for (int i = 0; i < list.getLength(); i++) {
			if (list.item(i) instanceof Element) {
				Element testcasecontentNode = (Element) list.item(i);
				TestcaseResultContent testcaseresult_content = this.getTestcaseresultContent(testcasecontentNode);
				testcaseresult_contents.add(testcaseresult_content);
			}
		}
		testcase_result.setTestcaseresult_contents(testcaseresult_contents);

		return testcase_result;
	}

	public TestcaseResultContent getTestcaseresultContent(Element testcasecontentElemet) {
		TestcaseResultContent testcaseresult_content = new TestcaseResultContent();
		if (testcasecontentElemet.getNodeName().equals("Comment")) {
			testcaseresult_content.setType("Comment");
		} else if (testcasecontentElemet.getNodeName().equals("Checkpoint")) {
			testcaseresult_content.setType("Checkpoint");
			testcaseresult_content.setResult(testcasecontentElemet
					.getAttribute("result"));
		} else {
			testcaseresult_content.setType(testcasecontentElemet.getNodeName());
		}
		testcaseresult_content.setValue(testcasecontentElemet.getTextContent());
		return testcaseresult_content;
	}

	private Document getXmlFile(String path) {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder db = null;
		Document xmlDoc = null;

		try {
			db = factory.newDocumentBuilder();

		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			xmlDoc = (Document) db.parse(new File(path));
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return xmlDoc;
	}

	public Properties getProperties(String path) {
		InputStream in = null;
		Properties p = new Properties();
		try {
			in = new BufferedInputStream(new FileInputStream(path));
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			p.load(in);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return p;
	}

	private String getFileName(String path) {
		File file = new File(path);
		String name = file.getName();
		return name;
	}

	private File[] getFiles(String path) {
		File file = new File(path);
		// get the folder list
		File[] files = file.listFiles();
		return files;
	}
}
