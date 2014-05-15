package com.paftp.service.TestcaseResultContent;

import java.util.List;

import com.paftp.entity.TestcaseResultContent;

public interface TestcaseResultContentService {

	public void saveTestcaseResultContent(TestcaseResultContent testcaseResultContent);

	public void updateTestcaseResultContent(TestcaseResultContent testcaseResultContent);

	public TestcaseResultContent findTestcaseResultContentById(int id);

	public void deleteTestcaseResultContent(TestcaseResultContent testcaseResultContent);

	public List<TestcaseResultContent> findAllList();
}
