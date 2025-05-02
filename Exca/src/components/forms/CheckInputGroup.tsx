import { ChangeEvent } from "react"
import { Condition } from "../../types"

type CheckInputGroupProps = {
    getValue: (id: number) => string
    condition: Condition
    handleChange: (e: ChangeEvent<HTMLInputElement | HTMLSelectElement>) => void
}

export default function CheckInputGroup({ getValue, condition, handleChange }: CheckInputGroupProps) {
    return (
        <div>
            <div>
                <div className='checkbox'>
                    <input type='checkbox' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                    <span className="checkmark"></span>
                </div>
            </div>
            <input value={getValue(condition.id)} onChange={handleChange} type='checkbox' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
        </div>
    )
}
