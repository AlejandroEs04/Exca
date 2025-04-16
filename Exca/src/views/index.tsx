import { useState } from "react"

export default function Index() {
    const [show, setShow] = useState(false)

    return (
        <div>
            <div>
                <div className="checkbox-group">
                    <label htmlFor="show">Intereses Moratorios</label>
                    <input type="checkbox" name="show" id="show" onChange={e => setShow(e.target.checked)} />
                </div>

                {show && (
                    <div>
                        <input type="text" name="condition" id="condition" placeholder="condition" />
                    </div>
                )}
            </div>
        </div>
    )
}
