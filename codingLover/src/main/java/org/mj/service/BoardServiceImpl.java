package org.mj.service;

import java.util.List;

import org.mj.domain.BoardVO;
import org.mj.dto.BoardDTO;
import org.mj.dto.BoardFileDTO;
import org.mj.dto.BoardListDTO;
import org.mj.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper mapper;

	@Override
	public List<BoardListDTO> getList() {
		return mapper.getList();
	}

	@Transactional
	@Override
	public int register(BoardVO board, List<BoardFileDTO> files) {
		try {
			mapper.insertSelectKey(board);
			int bno = board.getBno();
			for (BoardFileDTO boardFileDTO : files) {
				boardFileDTO.setBno(bno);
				mapper.insertFile(boardFileDTO);
			}
			return bno;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}

	}

	@Override
	public BoardDTO get(int bno) {
		mapper.updateHit(bno);

		BoardDTO result = mapper.read(bno);
		if (result.getCnt() > 0) {
			List<BoardFileDTO> files = mapper.readFile(bno);
			result.setFiles(files);
		}

		return result;
	}

	@Override
	public boolean modify(BoardVO board) {
		return mapper.update(board) > 0;
	}

}
