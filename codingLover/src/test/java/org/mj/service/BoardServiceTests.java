package org.mj.service;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.ArrayList;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mj.domain.BoardVO;
import org.mj.dto.BoardFileDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
// Java Config
// @ContextConfiguration(classes = {org.mj.config.RootConfig.class} )
@Log4j
public class BoardServiceTests {

	@Setter(onMethod_ = { @Autowired })
	private BoardService service;

	@Test
	public void testExist() {

		log.info(service);
		assertNotNull(service);
	}

	@Test
	public void testRegister() {

		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글");
		board.setContent("새로 작성하는 내용");
		board.setWriter("newbie");

		service.register(board, new ArrayList<BoardFileDTO>());
		int bno = board.getBno();

		log.info("생성된 게시물의 번호: " + bno);
		assertTrue(bno > 0);
	}



//	@Test
//	public void testGet() {
//
//		log.info(service.get(1L));
//	}



//	@Test
//	public void testUpdate() {
//
//		BoardVO board = service.get(1L);
//
//		if (board == null) {
//			return;
//		}
//
//		board.setTitle("제목 수정합니다.");
//		log.info("MODIFY RESULT: " + service.modify(board));
//	}

}
