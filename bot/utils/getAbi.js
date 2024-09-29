import fs from "fs";

function getAbi(buildPath) {
    const jsonBuild = fs.readFileSync(buildPath);
    const jsonBuildParsed = JSON.parse(jsonBuild);

    return jsonBuildParsed.abi;
}

export { getAbi };
