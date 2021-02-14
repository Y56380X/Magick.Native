# Copyright 2013-2021 Dirk Lemstra <https://github.com/dlemstra/Magick.Native/>
#
# Licensed under the ImageMagick License (the "License"); you may not use this file except in
# compliance with the License. You may obtain a copy of the License at
#
#   https://imagemagick.org/script/license.php
#
# Unless required by applicable law or agreed to in writing, software distributed under the
# License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
# either express or implied. See the License for the specific language governing permissions
# and limitations under the License.

param (
    [parameter(mandatory=$true)][string]$destination
)

. $PSScriptRoot\..\..\tools\windows\utils.ps1

function createNpmPackage($now)
{
  $info = $now.split('.')
  $version = "0.$($info[0])$($info[1]).$($info[2])$($info[3])"
  echo "::set-output name=version::$version"

  $path = FullPath "publish\wasm\package.json"
  $content = [IO.File]::ReadAllText($path)
  $content = $content.replace("""version"": """"", """version"": ""$version""")

  $packageJson = FullPath "publish\wasm\files\package.json"
  [IO.File]::WriteAllText($packageJson, $content)

  $dir = FullPath "publish\wasm\files"
  cd $dir
  & npm pack
}

$now = (Get-Date).ToUniversalTime().ToString("yyyy.MM.dd.HHmm")
createNpmPackage $now
