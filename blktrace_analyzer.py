import sys
import os

##sys.path.insert(0, os.environ["PYTHON_LIBS"] + "/gviz_api_py-1.8.2")

##import gviz_api
##import json

columnDescriptions_local = [("Time","number"),("Action","string"),("Type", "string"), ("BlkNo","long"),("Size","int"),("Pid","int"),("ProcName", "string"),("Processor","int")]
columnIndexMap = {"Time":0,"Action":1,"Type":2,"BlkNo":3,"Size":4, "Pid":5, "ProcName":6, "Processor":7}
columnDescriptions = [("Time","number"),("Action","string"),("Type", "string"), ("BlkNo","number"),("Size","number"),("Pid","number"),("ProcName", "string"),("Processor","number")]

class bltrace_analyzer:

    def __init__(self, log_file_path):
        self.log_file_path = log_file_path
        self.columnDescriptions = columnDescriptions
        self._createInternalDS()
        #self._createDataTable()

    def _createInternalDS(self):
        self.lst_rows_data = []
        fp = file(self.log_file_path)

        for line in fp:
            linedata= line.split()
            if len(linedata) > 8:
                for i in range(7,len(linedata) - 1):
                    linedata[6] = linedata[6] + " " + linedata[i]

                linedata[7] = linedata[len(linedata) - 1]
                linedata.__delslice__(8,len(linedata))

            self._coerceData(linedata)

            self.lst_rows_data.append(linedata)

    def _createDataTable(self):
        self.blTrace_DataTable = gviz_api.DataTable(self.columnDescriptions)
        fp = file(self.log_file_path)

        for line in fp:
            linedata= line.split()
            if len(linedata) > 8:
                for i in range(7,len(linedata) - 1):
                    linedata[6] = linedata[6] + " " + linedata[i]

                linedata[7] = linedata[len(linedata) - 1]
                linedata.__delslice__(8,len(linedata))

            self._coerceData(linedata)

            self.blTrace_DataTable.AppendData([linedata])

    def _coerceData(self, linedata):
        for i, data in enumerate(linedata):
            if columnDescriptions_local[i][1] == "number":
                linedata[i] = float(data)
            elif columnDescriptions_local[i][1] == "int":
                linedata[i] = int(data)
            elif columnDescriptions_local[i][1] == "long":
                linedata[i] = long(data)

    def displayWriteTimes(self, blk_size):
        json_temp = {}
        lst_blk_accesses = []

        CONST_ACTION = "Action"
        CONST_SIZE = "Size"
        CONST_TIME = "Time"
        CONST_BLKNO = "BlkNo"

        for row in self.lst_rows_data:
            if row[columnIndexMap[CONST_SIZE]] == blk_size and row[columnIndexMap[CONST_ACTION]] == "D":
                json_temp.__setitem__(row[columnIndexMap[CONST_BLKNO]], row[columnIndexMap[CONST_TIME]])
            elif row[columnIndexMap[CONST_SIZE]] == blk_size and row[columnIndexMap[CONST_ACTION]] == "C":
                if json_temp.has_key(row[columnIndexMap[CONST_BLKNO]]):
                    tpl_time_diff = (row[columnIndexMap[CONST_BLKNO]], row[columnIndexMap[CONST_TIME]] - json_temp[row[columnIndexMap[CONST_BLKNO]]])
                    lst_blk_accesses.append(tpl_time_diff)
                    json_temp.__delitem__(row[columnIndexMap[CONST_BLKNO]])

	print("Block No   Time difference")        
	for tpl in lst_blk_accesses:
            print(tpl)

    # def displayWriteTimes(self, blk_size):
    #     json_bltrace = self.blTrace_DataTable.ToJSon()
    #     json_temp = {}
    #     lst_blk_accesses = []
    #
    #     for row in json_bltrace:
    #         if row["Action"] == "D":
    #             json_temp.__setitem__(row["BlkNo"], row["Time"])
    #         elif row["Action"] == "C":
    #             if json_temp.has_key(row["BlkNo"]):
    #                 tpl_time_diff = (row["BlkNo"], row["Time"] - json_temp[row["BlkNo"]])
    #                 lst_blk_accesses.append(tpl_time_diff)
    #                 json_temp.__delitem__(row["BlkNo"])
    #
    #     for tpl in lst_blk_accesses:
    #         print(tpl)

if __name__ == "__main__":
    blk_analyzer = bltrace_analyzer("~/bltrace/AngryBird.log")
    bltrace_analyzer.displayWriteTimes(blk_analyzer, 8)
