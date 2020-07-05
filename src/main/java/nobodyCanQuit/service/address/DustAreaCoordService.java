package nobodyCanQuit.service.address;

import nobodyCanQuit.web.model.address.AddressCommand;
import nobodyCanQuit.web.model.address.Result;
import nobodyCanQuit.web.model.viligeDust.DustArea;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.*;

@Service
public class DustAreaCoordService {

    @Autowired
    private CoordService coordService;

    public List<DustArea> getConvertedList(AddressCommand addressCommand, List<DustArea> dustList) throws IOException {

        List<Result> list = addressCommand.getResultList();
        List<Result> names = new ArrayList<>(list.size());

        int i = 0;
        for (Result result : list) {
            names.add(new Result());
            names.get(i).setName(result.getName());
            names.get(i).setXCoor(result.getX());
            names.get(i).setYCoor(result.getY());
            i++;
        }

        for (Result t : names) {
            if (t.getName().contains(" ")) {
                t.setName(t.getName().substring(0, t.getName().indexOf(" ")));
            }
        }

        HashSet<Result> namesSet = new HashSet<>(names);
        names = new ArrayList<>(namesSet);

        HashSet<DustArea> dustSet = new HashSet<>(dustList);
        dustList = new ArrayList<>(dustSet);

        names.sort((s, b)-> s.toString().compareTo(b.toString()));
        dustList.sort((s,b)-> s.toString().compareTo(b.toString()));

        dustList = coordService.convert(names, dustList,
                CoordService.CoordSystem.UTM, CoordService.CoordSystem.WGS84);

        return dustList;
    }

}