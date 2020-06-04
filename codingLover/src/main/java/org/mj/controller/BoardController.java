package org.mj.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import org.mj.domain.BoardFileVO;
import org.mj.domain.BoardVO;
import org.mj.dto.BoardDTO;
import org.mj.dto.BoardFileDTO;
import org.mj.dto.BoardListDTO;
import org.mj.dto.BoardModifyDTO;
import org.mj.dto.BoardRegisterDTO;
import org.mj.service.BoardService;
import org.mj.util.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Autowired
	BoardService service;

	@GetMapping(value = "/list", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<BoardListDTO> list() {
		return service.getList();
	}

	@PostMapping(value = "/register", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String[] register(BoardRegisterDTO register, @RequestParam("uploadFile") MultipartFile[] uploadFile) {
		log.info("/register -------------------> \\n" + register);
		log.info("/register -------------------> uploadFile.length : " + uploadFile.length);

		//final String UPLOAD_FOLDER = "c:\\upload";
		final String UPLOAD_FOLDER = "D:\\codingLover_workspace\\codingLover\\src\\main\\webapp\\resources\\upload";
		File uploadPath = new File(UPLOAD_FOLDER, FileUtils.getFolderName());
		if (!uploadPath.exists()) {
			uploadPath.mkdirs();
		}

		BoardVO board = register.getBoard();
		
		List<BoardFileDTO> files = new ArrayList<BoardFileDTO>();
		BoardFileDTO boardFile = null;

		for (MultipartFile multipartFile : uploadFile) {
			boardFile = new BoardFileDTO();

			String originFileName = multipartFile.getOriginalFilename();
			originFileName = originFileName.substring(originFileName.lastIndexOf("\\") + 1);
			UUID uuid = UUID.randomUUID();
			String fileName = uuid.toString() + "_" + originFileName;

			long fileSize = multipartFile.getSize();

			try {
				File saveFile = new File(uploadPath, fileName);
				multipartFile.transferTo(saveFile);
			} catch (Exception e) {

			}
			log.info("/register -------------------> fileName: " + fileName);
			log.info("/register -------------------> originFileName : " + originFileName);
			boardFile.setFileName(fileName);
			boardFile.setOriginFileName(originFileName);
			boardFile.setFileSize(fileSize);
			boardFile.setFilePath(uploadPath.toString());
			log.info("/register -------------------> boardFile : " + boardFile.toString());
			files.add(boardFile);
			log.info("/register -------------------> files : " + files.toString());

		}
		int result = service.register(board, files);
		log.info("/register -------------------> result : " + result);
		String[] resultArr = {result != -1 ? "success" : "fail" , result+""};
		log.info("/register -------------------> resultArr : " + Arrays.toString(resultArr));
		return resultArr;
	}

	@GetMapping(value = "/get", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public BoardDTO get(@RequestParam("bno") int bno) {
		log.info("/get -------------------> bno : " + bno);
		BoardDTO result = service.get(bno);
		log.info("/get -------------------> result : \n" + result);
		return result;
	}

	@PostMapping(value = "/modify")
	@ResponseBody
	public String modify(BoardModifyDTO board) {
		log.info("modify:" + board);

		BoardVO vo = new BoardVO();
		vo.setBno(board.getBno());
		vo.setTitle(board.getTitle());
		vo.setContent(board.getContent());

		return service.modify(vo) ? "success" : "fail";
	}
}
